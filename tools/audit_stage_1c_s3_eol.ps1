$ext=@('.zig','.zon','.c','.h','.bat','.cmd','.vpy','.md','.txt','.patch','.diff','.py','.ps1','.json','.yml','.yaml')
$rootFiles=@('build.zig','build.zig.zon','build_1C_v1.bat')
$prefixes=@('src/','tests/','tools/','third_party/')
$paths=git ls-files -co --exclude-standard
$bad=@()
foreach($r in $paths){
    $normalized=$r.Replace([char]92,[char]47)
    $inDomain=($rootFiles -contains $normalized)
    if(-not $inDomain){
        foreach($prefix in $prefixes){
            if($normalized.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){
                $inDomain=$true
                break
            }
        }
    }
    if(-not $inDomain){continue}
    if(-not(Test-Path -LiteralPath $r)){continue}
    $f=Get-Item -LiteralPath $r
    if($f.PSIsContainer){continue}
    if($ext -notcontains $f.Extension.ToLowerInvariant()){continue}
    $b=[IO.File]::ReadAllBytes($f.FullName)
    for($i=0;$i -lt $b.Length;$i++){
        if($b[$i] -gt 127){
            $bad+=($r+' non-ASCII')
            break
        }
        if($b[$i] -eq 10 -and ($i -eq 0 -or $b[$i-1] -ne 13)){
            $bad+=($r+' bare-LF')
            break
        }
    }
}
if($bad){
    $bad | % {Write-Host $_}
    exit 1
}
Write-Host 'S3_STAGE_1C_DELIVERABLE_TREE_PASS'
