$checks=@(@('src/cpu_capability_detection.zig','enable_force_down','force_down_debug.zig'),@('src/cpu_capability_detection.zig','enable_verbose_detection','print_diag_helper_functions.zig'),@('src/deblock4_plugin.zig','enable_trace_lifecycle','lifecycle_trace_debug.zig'),@('src/deblock4_selftest.zig','enable_trace_lifecycle','lifecycle_trace_debug.zig'))
foreach($c in $checks){
    $s=[IO.File]::ReadAllText($c[0])
    $r='if\s*\([^\)]*'+[regex]::Escape($c[1])+'[^\)]*\)\s*@import\("'+[regex]::Escape($c[2])+'"\)\s*else\s*struct'
    if($s -notmatch $r){
        Write-Host ('missing gate '+$c[0]+' '+$c[2])
        exit 1
    }
}
Write-Host 'G10_SOURCE_GATES_PASS'
