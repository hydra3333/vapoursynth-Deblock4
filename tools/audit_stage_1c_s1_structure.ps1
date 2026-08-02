$frame=@('src/classic_callback_router.zig','src/deblock4_callback_router.zig','src/classic_ar_initial.zig','src/deblock4_ar_initial.zig','src/classic_ar_all_frames_ready.zig','src/deblock4_ar_all_frames_ready.zig')
$bad=@()
foreach($f in $frame){
    $s=[IO.File]::ReadAllText($f)
    if($s -match '@import\("(?:backend_tier_selection|cpu_capability_detection)\.zig"\)|DEBLOCK4_FORCE_DOWN'){
        $bad += $f
    }
}
$pure=@('src/backend_tier_selection.zig','src/filter_call_parameters.zig','src/common_instance_data_structure.zig','src/deblock4_version.zig')
foreach($f in $pure){
    $s=[IO.File]::ReadAllText($f)
    if($s -match 'vapoursynth_api4|zig_vsh_|VSAPI'){
        $bad += $f
    }
}
$cpu=[IO.File]::ReadAllText('src/cpu_capability_detection.zig')
if($cpu -match 'classic_|deblock4_(?:plugin|instance|callback|ar_|frame_)'){
    $bad += 'src/cpu_capability_detection.zig'
}
if($bad){
    $bad | % {Write-Host $_}
    exit 1
}
Write-Host 'S1_STRUCTURAL_PASS'
