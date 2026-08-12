import hashlib
import json
import os
import vapoursynth as vs


class _NoAutoloadPolicy(vs.EnvironmentPolicy):
    def on_policy_registered(self, api):
        self._api = api
        self._environment = api.create_environment(int(vs.DISABLE_AUTO_LOADING))

    def on_policy_cleared(self):
        if self._api is not None and self._environment is not None:
            self._api.destroy_environment(self._environment)
        self._environment = None
        self._api = None

    def get_current_environment(self):
        return self._environment

    def set_environment(self, environment):
        del environment
        return self._environment

    def is_alive(self, environment):
        return environment is self._environment


if vs.has_policy():
    raise RuntimeError("HolyWu differential requires direct Python before a VapourSynth policy is registered")
_isolation_policy = _NoAutoloadPolicy()
vs.register_policy(_isolation_policy)
core = vs.core
if (core.flags & int(vs.DISABLE_AUTO_LOADING)) == 0:
    raise RuntimeError("HolyWu differential core was not created with autoload disabled")
MODE = os.environ.get("DEBLOCK4_HOLYWU_MODE", "guard_selftests")
PLUGIN_PATH = os.environ.get("DEBLOCK4_PLUGIN_PATH", "")
REFERENCE_PLUGIN_PATH = os.environ.get("DEBLOCK4_HOLYWU_PLUGIN_PATH", "")
PRELIMINARY_RECORD = os.environ.get("DEBLOCK4_HOLYWU_RECORD_PATH", "")
COMPLETED_RECORD = os.environ.get("DEBLOCK4_HOLYWU_COMPLETED_RECORD_PATH", "")
INSPECTION_DIR = os.environ.get("DEBLOCK4_INSPECTION_DIR", "")
EXPECTED_VERSION = os.environ.get("DEBLOCK4_EXPECTED_VERSION", "0.1.0-dev+2C")

for name, value in (
    ("DEBLOCK4_PLUGIN_PATH", PLUGIN_PATH),
    ("DEBLOCK4_HOLYWU_PLUGIN_PATH", REFERENCE_PLUGIN_PATH),
    ("DEBLOCK4_HOLYWU_RECORD_PATH", PRELIMINARY_RECORD),
    ("DEBLOCK4_INSPECTION_DIR", INSPECTION_DIR),
):
    if not value:
        raise RuntimeError("%s is required" % name)
os.makedirs(INSPECTION_DIR, exist_ok=True)


def _sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _load_record(path):
    with open(path, "r", encoding="ascii") as handle:
        return json.load(handle)


def _verify_record_and_dll(record):
    expected = record["reference_plugin"]["dll_sha256"].lower()
    actual = _sha256(REFERENCE_PLUGIN_PATH)
    if actual != expected:
        raise RuntimeError("reference DLL hash mismatch expected=%s actual=%s" % (expected, actual))
    if record.get("preprocessor_definitions") != ["DEBLOCK_X86 ABSENT"]:
        raise RuntimeError("reference record does not prove DEBLOCK_X86 absent")
    if record.get("post_build_source_hashes") != record.get("pinned_source_hashes"):
        raise RuntimeError("reference record does not prove pinned source remained byte-exact during build")
    return actual


record = _load_record(PRELIMINARY_RECORD)
reference_hash = _verify_record_and_dll(record)
preloaded_namespaces = {plugin.namespace for plugin in core.plugins()}
if "deblock4" in preloaded_namespaces or "deblock" in preloaded_namespaces:
    raise RuntimeError("HolyWu differential autoload isolation failed before manual plugin loading")
core.std.LoadPlugin(path=PLUGIN_PATH)
core.std.LoadPlugin(path=REFERENCE_PLUGIN_PATH)


def _normalized_path(path):
    return os.path.normcase(os.path.abspath(path))


if _normalized_path(core.deblock4.plugin_path) != _normalized_path(PLUGIN_PATH):
    raise RuntimeError("Deblock4 plugin provenance mismatch under isolated core")
if _normalized_path(core.deblock.plugin_path) != _normalized_path(REFERENCE_PLUGIN_PATH):
    raise RuntimeError("HolyWu reference plugin provenance mismatch under isolated core")
print("STAGE_2C_HOLYWU_ISOLATED_CORE_PASS autoload=disabled")


def _prop_text(value):
    return value.decode("utf-8") if isinstance(value, bytes) else str(value)


def _make_clip(width, height, fmt, fill, length=2):
    base = core.std.BlankClip(width=width, height=height, length=length, format=fmt, fpsnum=25, fpsden=1)
    def selector(n, f):
        del n
        out = f.copy()
        for plane in range(out.format.num_planes):
            array = out[plane]
            h, w = array.shape
            for y in range(h):
                for x in range(w):
                    array[y, x] = fill(plane, y, x, out.format.bits_per_sample)
        return out
    return core.std.ModifyFrame(clip=base, clips=base, selector=selector)


def _cb(width, height, fmt, lo, hi):
    return _make_clip(width, height, fmt, lambda p,y,x,b: (lo if (((y//8)+(x//8))&1)==0 else hi) * (1 << (b-8)))


def _plane_bytes(frame, plane):
    array = frame[plane]
    h, w = array.shape
    bps = frame.format.bytes_per_sample
    out = bytearray()
    for y in range(h):
        for x in range(w):
            out += int(array[y,x]).to_bytes(bps, "little")
    return bytes(out)


def _first_difference(a, b, plane, frame_number):
    aa = a[plane]
    bb = b[plane]
    h, w = aa.shape
    for y in range(h):
        for x in range(w):
            av, bv = int(aa[y,x]), int(bb[y,x])
            if av != bv:
                return dict(frame=frame_number, plane=plane, x=x, y=y, deblock4=av, holywu=bv)
    return None


def _validate_domain_metadata(sample_type, bits_per_sample, bytes_per_sample, color_family, num_planes):
    if sample_type != vs.INTEGER:
        raise ValueError("comparison input must be integer")
    if not 8 <= bits_per_sample <= 16:
        raise ValueError("comparison bit depth outside 8..16")
    expected_bps = 1 if bits_per_sample == 8 else 2
    if bytes_per_sample != expected_bps:
        raise ValueError("bytes-per-sample inconsistent with bit depth")
    if color_family not in (vs.GRAY, vs.YUV, vs.RGB):
        raise ValueError("unsupported comparison colour family")
    if num_planes < 1 or num_planes > 3:
        raise ValueError("unsupported comparison plane count")


def _guard(request, source, source_frame, expected_dll_hash):
    if request.get("classic_backend") != "x86_64_v1_baseline":
        raise ValueError("Classic backend must be explicit x86_64_v1_baseline")
    if request.get("holywu_opt") != 1:
        raise ValueError("HolyWu opt must be exactly 1")
    if expected_dll_hash.lower() != _sha256(REFERENCE_PLUGIN_PATH):
        raise ValueError("reference DLL hash guard failed")
    if source.format is None or source.width <= 0 or source.height <= 0:
        raise ValueError("comparison input must have constant format and dimensions")
    fmt = source_frame.format
    if fmt is None or fmt.id != source.format.id:
        raise ValueError("fetched frame format differs from constant node format")
    if source_frame.width != source.width or source_frame.height != source.height:
        raise ValueError("fetched frame dimensions differ from constant node dimensions")
    _validate_domain_metadata(
        fmt.sample_type,
        fmt.bits_per_sample,
        fmt.bytes_per_sample,
        fmt.color_family,
        fmt.num_planes,
    )
    strength = request["strength"]
    aoff = request["aoffset"]
    boff = request["boffset"]
    if not 0 <= strength <= 60:
        raise ValueError("strength outside shared domain")
    if not (-strength <= aoff <= 60-strength and -strength <= boff <= 60-strength):
        raise ValueError("offset outside shared domain")
    planes = request["planes"]
    selected = list(range(fmt.num_planes)) if planes is None else list(planes)
    if len(set(selected)) != len(selected) or any(p < 0 or p >= fmt.num_planes for p in selected):
        raise ValueError("illegal plane selection")
    for plane in range(fmt.num_planes):
        arr = source_frame[plane]
        h, w = arr.shape
        subsampling_w = fmt.subsampling_w if plane > 0 and fmt.color_family == vs.YUV else 0
        subsampling_h = fmt.subsampling_h if plane > 0 and fmt.color_family == vs.YUV else 0
        expected_w = (source.width + (1 << subsampling_w) - 1) >> subsampling_w
        expected_h = (source.height + (1 << subsampling_h) - 1) >> subsampling_h
        if w != expected_w or h != expected_h:
            raise ValueError("actual plane array dimensions disagree with node format/dimensions")
        if w % 8 or h % 8:
            raise ValueError("every compared plane must be mod-8")
    return selected


def _expect_guard_failure(label, thunk):
    try:
        thunk()
    except ValueError:
        return
    raise RuntimeError("H4 guard negative control did not fail: %s" % label)


def _classic(source, case):
    args = dict(
        clip=source,
        strength=case["strength"],
        boundary_strength_offset=case["aoffset"],
        side_activity_offset=case["boffset"],
        backend="x86_64_v1_baseline",
    )
    if case["planes"] is not None:
        args["planes"] = case["planes"]
    return core.deblock4.Classic(**args)


def _holywu(source, case):
    args = dict(
        clip=source,
        quant=case["strength"],
        aoffset=case["aoffset"],
        boffset=case["boffset"],
        opt=1,
    )
    if case["planes"] is not None:
        args["planes"] = case["planes"]
    return core.deblock.Deblock(**args)


def _changed_count(source, output, plane):
    a = source[plane]; b = output[plane]
    h, w = a.shape
    return sum(1 for y in range(h) for x in range(w) if int(a[y,x]) != int(b[y,x]))


def _sentinel_clip(kind, orientation):
    if kind == "B2": filler, quant, taps, expected = 100,25,[110,110,110,100,100,100],[109,107,103,101]
    elif kind == "B4": filler, quant, taps, expected = 0,25,[0,0,0,9,9,9],[1,3,6,8]
    elif kind == "B5": filler, quant, taps, expected = 195,60,[195,195,195,5,5,5],[160,158,42,40]
    else: raise RuntimeError("bad sentinel")
    def fill(p,y,x,b):
        del p,b
        if orientation == "V" and y == 0 and 1 <= x <= 6:
            return taps[x-1]
        if orientation == "H" and x == 0 and 1 <= y <= 6:
            return taps[y-1]
        return filler
    coords = [(x,0) for x in range(2,6)] if orientation == "V" else [(0,y) for y in range(2,6)]
    return _make_clip(16,8,vs.GRAY8,fill,length=1), quant, expected, coords


def _run_sentinels():
    observations=[]
    for orientation in ("V","H"):
        for kind in ("B2","B4","B5"):
            source, quant, expected, coords = _sentinel_clip(kind, orientation)
            source_frame = source.get_frame(0)
            request = dict(classic_backend="x86_64_v1_baseline", holywu_opt=1, strength=quant, aoffset=0, boffset=0, planes=None)
            _guard(request, source, source_frame, reference_hash)
            output = core.deblock.Deblock(clip=source, quant=quant, aoffset=0, boffset=0, opt=1).get_frame(0)
            array = output[0]
            observed = [int(array[y,x]) for x,y in coords]
            if observed != expected:
                raise RuntimeError("sentinel %s-%s mismatch: %r != %r" % (orientation,kind,observed,expected))
            changed=[]
            src_array=source_frame[0]
            for y in range(8):
                for x in range(16):
                    if int(src_array[y,x]) != int(array[y,x]): changed.append((x,y))
            if changed != coords:
                raise RuntimeError("sentinel %s-%s changed unexpected cells: %r" % (orientation,kind,changed))
            observations.append(dict(id="%s-%s"%(orientation,kind), expected=expected, observed=observed, changed_cells=changed))
    probe_source=_cb(64,64,vs.GRAY8,100,108)
    probe_case=dict(strength=25,aoffset=0,boffset=0,planes=None)
    probe_frame=_classic(probe_source,probe_case).get_frame(0)
    observed_version=_prop_text(probe_frame.props["Deblock4Version"])
    observed_tier=_prop_text(probe_frame.props["Deblock4Tier"])
    if observed_version != EXPECTED_VERSION:
        raise RuntimeError("Deblock4 runtime identity mismatch: %r != %r"%(observed_version,EXPECTED_VERSION))
    if observed_tier != "x86_64_v1_baseline":
        raise RuntimeError("Deblock4 runtime tier mismatch: %r"%observed_tier)
    runtime_version=getattr(vs,"__version__",None)
    if runtime_version is None:
        runtime_version=core.version()
    record["completion_state"]="sentinels-validated"
    record["vapoursynth_runtime_version"]=str(runtime_version)
    record["deblock4_plugin"]={
        "version":observed_version,
        "tier":observed_tier,
        "dll_path":PLUGIN_PATH,
        "dll_sha256":_sha256(PLUGIN_PATH),
    }
    record["sentinel_observations"]=observations
    target=COMPLETED_RECORD or os.path.join(INSPECTION_DIR,"reference-build-record.completed.json")
    with open(target,"w",encoding="ascii",newline="\n") as handle: json.dump(record,handle,indent=2,sort_keys=True)
    print("STAGE_2C_HOLYWU_SENTINELS_PASS dll_sha256=%s record=%s"%(reference_hash,target))
    core.std.BlankClip(width=16,height=8,length=1,format=vs.GRAY8).set_output()


def _run_guard_selftests():
    source=_cb(64,64,vs.GRAY8,100,108); frame=source.get_frame(0)
    good=dict(classic_backend="x86_64_v1_baseline",holywu_opt=1,strength=25,aoffset=0,boffset=0,planes=None)
    _expect_guard_failure("missing opt",lambda:_guard(dict(good,holywu_opt=None),source,frame,reference_hash))
    _expect_guard_failure("missing backend",lambda:_guard(dict(good,classic_backend=None),source,frame,reference_hash))
    _expect_guard_failure("auto backend",lambda:_guard(dict(good,classic_backend="auto"),source,frame,reference_hash))
    bad_geometry_source=_cb(48,30,vs.GRAY8,100,108)
    _expect_guard_failure("non-mod8",lambda:_guard(good,bad_geometry_source,bad_geometry_source.get_frame(0),reference_hash))
    float_source=core.std.BlankClip(width=64,height=64,length=1,format=vs.GRAYS)
    _expect_guard_failure("float",lambda:_guard(good,float_source,float_source.get_frame(0),reference_hash))
    _expect_guard_failure("offset",lambda:_guard(dict(good,aoffset=36),source,frame,reference_hash))
    _expect_guard_failure("wrong hash",lambda:_guard(good,source,frame,"0"*64))
    for bits in range(17,33):
        bad_format=core.query_video_format(vs.GRAY,vs.INTEGER,bits,0,0)
        bad_source=core.std.BlankClip(width=64,height=64,length=1,format=bad_format.id)
        _expect_guard_failure("integer depth %d"%bits,lambda bs=bad_source:_guard(good,bs,bs.get_frame(0),reference_hash))
    _expect_guard_failure(
        "inconsistent metadata",
        lambda:_validate_domain_metadata(vs.INTEGER,8,2,vs.GRAY,1),
    )
    print("STAGE_2C_HOLYWU_GUARD_SELFTESTS_PASS")
    source.set_output()


FORMATS = {
    "GRAY8":vs.GRAY8,"YUV420P8":vs.YUV420P8,"YUV422P8":vs.YUV422P8,
    "YUV444P8":vs.YUV444P8,"RGB24":vs.RGB24,"GRAY10":vs.GRAY10,
    "GRAY12":vs.GRAY12,"GRAY16":vs.GRAY16,"YUV420P10":vs.YUV420P10,
}
CASES = [
("C01","GRAY8",64,64,None,25,0,0,100,108,True),
("C02","GRAY8",64,64,None,0,0,0,100,108,False),
("C03","GRAY8",64,64,None,60,0,0,100,108,True),
("C04","YUV420P8",64,64,None,25,0,0,100,108,True),
("C05","YUV420P8",64,64,[1],25,0,0,100,108,True),
("C06","YUV422P8",64,64,[2],25,0,0,100,108,True),
("C07","YUV444P8",64,64,None,25,0,0,100,108,True),
("C08","RGB24",64,64,[1],25,0,0,100,108,True),
("C09","GRAY8",64,64,None,25,-9,0,100,103,True),
("C10","GRAY8",64,64,None,25,0,-9,100,103,True),
("C11","GRAY8",64,64,None,25,-9,35,100,103,True),
("C12","GRAY8",64,64,None,25,35,0,100,103,True),
("C13","GRAY10",64,64,None,25,0,0,100,108,True),
("C14","GRAY12",64,64,None,25,0,0,100,108,True),
("C15","GRAY16",64,64,None,25,0,0,100,108,True),
("C16","YUV420P10",64,64,None,25,0,0,100,108,True),
("C17","YUV420P8",48,32,None,25,0,0,100,108,True),
]


def _run_corpus():
    if record.get("completion_state") != "sentinels-validated":
        raise RuntimeError("completed sentinel-validated record is required for H5")
    summaries=[]
    first_failure=None
    last_clip=None
    for cid,fmt_name,w,h,planes,strength,aoff,boff,lo,hi,nonvacuous in CASES:
        source=_cb(w,h,FORMATS[fmt_name],lo,hi)
        source_frame=source.get_frame(0)
        case=dict(id=cid,format=fmt_name,width=w,height=h,planes=planes,strength=strength,aoffset=aoff,boffset=boff,classic_backend="x86_64_v1_baseline",holywu_opt=1)
        print("STAGE_2C_HOLYWU_CASE invocation=" + json.dumps(case, sort_keys=True, separators=(",", ":")))
        selected=_guard(case,source,source_frame,reference_hash)
        classic=_classic(source,case); holywu=_holywu(source,case); last_clip=classic
        case_summary=dict(id=cid,invocation=case,differences=0,changed_samples={})
        for n in range(2):
            cf=classic.get_frame(n); hf=holywu.get_frame(n); sf=source.get_frame(n)
            selected_n=_guard(case,source,sf,reference_hash)
            if selected_n != selected:
                raise RuntimeError("actual-input guard plane selection drift: %s"%cid)
            for plane in range(sf.format.num_planes):
                cb=_plane_bytes(cf,plane); hb=_plane_bytes(hf,plane)
                if cb != hb:
                    diff=_first_difference(cf,hf,plane,n)
                    case_summary["differences"] += 1
                    if first_failure is None: first_failure=dict(case=cid,**diff)
                changes=_changed_count(sf,cf,plane)
                case_summary["changed_samples"]["frame%d_plane%d"%(n,plane)]=changes
                if plane in selected:
                    if nonvacuous and changes < 1: raise RuntimeError("%s selected plane %d was vacuous"%(cid,plane))
                    if not nonvacuous and changes != 0: raise RuntimeError("%s identity case changed plane %d"%(cid,plane))
                elif _plane_bytes(sf,plane) != cb:
                    raise RuntimeError("%s unselected plane %d changed"%(cid,plane))
        summaries.append(case_summary)
    summary_path=os.path.join(INSPECTION_DIR,"stage_2c_holywu_difference_summary.json")
    output=dict(
        reference_dll_sha256=reference_hash,
        cases=summaries,
        first_difference=first_failure,
        output_location=summary_path,
    )
    with open(summary_path,"w",encoding="ascii",newline="\n") as handle: json.dump(output,handle,indent=2,sort_keys=True)
    if first_failure is not None:
        print("STAGE_2C_HOLYWU_DIFF_FAIL case={case} frame={frame} plane={plane} x={x} y={y} deblock4={deblock4} holywu={holywu}".format(**first_failure))
        raise RuntimeError("unratified HolyWu difference; see %s"%summary_path)
    print("STAGE_2C_HOLYWU_DIFF_PASS cases=17 summary=%s"%summary_path)
    last_clip.set_output()


if MODE == "guard_selftests": _run_guard_selftests()
elif MODE == "sentinels": _run_sentinels()
elif MODE == "corpus":
    if COMPLETED_RECORD:
        record = _load_record(COMPLETED_RECORD)
        PRELIMINARY_RECORD = COMPLETED_RECORD
        reference_hash = _verify_record_and_dll(record)
    _run_corpus()
else: raise RuntimeError("unknown DEBLOCK4_HOLYWU_MODE: %s"%MODE)
