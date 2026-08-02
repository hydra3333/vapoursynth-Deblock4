$ret=@('build_1B1_v7_3.bat','build_1B2_v5_REDEVELOPED.bat','build_1B3_v5.bat','src/backend_isolation_smoke_test.zig','src/backend_probe_avx2.zig','src/backend_probe_generic.zig','src/backend_probe_scalar.zig','src/backend_probe_sse41.zig','src/backend_retention_anchor.zig','src/build_probe.zig','src/dll_probe.zig','src/dll_smoke_test.zig','src/vapoursynth_header_probe.zig')
foreach($f in $ret){
    if(Test-Path -LiteralPath $f){
        Write-Host ('retired file remains: '+$f)
        exit 1
    }
}
$roots=@('build.zig','build.zig.zon','src','tests','tools')
$files=@()
foreach($r in $roots){
    if(Test-Path $r){
        $i=Get-Item $r
        if($i.PSIsContainer){
            $files+=Get-ChildItem $r -Recurse -File
        }else{
            $files+=$i
        }
    }
}
$names=$ret | % {[IO.Path]::GetFileName($_)}
$selfPath=(Resolve-Path -LiteralPath $PSCommandPath).Path
foreach($f in $files){
    if($f.Name -eq 'build_1C_v1.bat'){continue}
    if($f.FullName -eq $selfPath){continue}
    $s=[IO.File]::ReadAllText($f.FullName)
    foreach($n in $names){
        if($s.Contains($n)){
            Write-Host ('retired reference '+$n+' in '+$f.FullName)
            exit 1
        }
    }
}
Write-Host 'S2_SWEEP_PASS'
