$ext=@('.zig','.zon','.c','.h','.bat','.cmd','.vpy','.md','.txt','.patch','.diff','.py','.ps1','.json','.yml','.yaml')
$paths=git ls-files -co --exclude-standard
$bad=@()
foreach($r in $paths){
    if(-not(Test-Path -LiteralPath $r)){continue}
    $f=Get-Item -LiteralPath $r
    if($f.PSIsContainer){continue}
    if(($ext -notcontains $f.Extension.ToLowerInvariant()) -and $f.Name -ne '.gitignore'){continue}
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
Write-Host 'S3_ZERO_LF_TEXT_FILES_PASS'
