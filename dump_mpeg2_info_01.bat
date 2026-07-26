@echo off
setlocal

set "mediainfo=C:\SOFTWARE\MediaInfo\MediaInfo.exe"
set "ffmpeg=C:\SOFTWARE\ffmpeg\ffmpeg.exe"
set "ffprobe=C:\SOFTWARE\ffmpeg\ffprobe.exe"

call :produce_log "D:\VHS\home_576i.mpg"
call :produce_log "D:\VHS\home_576p.mpg"

pause
exit /b

:produce_log
set "src=%~dpnx1"
set "log=%~dpn1_info.log"
set "biglog=%~dpn1_info_big.log"

echo src=%SRC% >"%log%" 2>&1
echo.>>"%log%" 2>&1

echo src=%SRC% >"%biglog%" 2>&1
echo.>>"%biglog%" 2>&1

echo ================================================================ >>"%log%" 2>&1
echo == 1. MediaInfo summary container + stream level >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo.>>"%log%" 2>&1
echo "%mediainfo%" "%SRC%" >>"%log%" 2>&1
"%mediainfo%" "%SRC%" >>"%log%" 2>&1
echo.>>"%log%" 2>&1

echo. >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo == 2. ffprobe stream summary codec, size, field order, pix_fmt >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo.>>"%log%" 2>&1
echo "%ffprobe%" -v error -select_streams v:0 -show_entries stream=codec_name,width,height,field_order,pix_fmt,color_range -of default=noprint_wrappers=1 "%SRC%" >>"%log%" 2>&1
"%ffprobe%" -v error -select_streams v:0 -show_entries stream=codec_name,width,height,field_order,pix_fmt,color_range -of default=noprint_wrappers=1 "%SRC%" >>"%log%" 2>&1
echo.>>"%log%" 2>&1

echo. >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo == 3. ffprobe first 6 frames picture type, interlace flags >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo.>>"%log%" 2>&1
echo "%ffprobe%" -v error -select_streams v:0 -read_intervals "%%+#6" -show_entries frame=pict_type,interlaced_frame,top_field_first,repeat_pict -of csv "%SRC%" >>"%log%" 2>&1
"%ffprobe%" -v error -select_streams v:0 -read_intervals "%%+#6" -show_entries frame=pict_type,interlaced_frame,top_field_first,repeat_pict -of csv "%SRC%" >>"%log%" 2>&1
echo.>>"%log%" 2>&1

echo. >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo == 4. ffmpeg per-macroblock DCT/type debug, first 6 frames >>"%log%" 2>&1
echo ==    verbose; captured to "%biglog%" >>"%log%" 2>&1
echo ================================================================ >>"%log%" 2>&1
echo.>>"%log%" 2>&1
echo this commands dumps big data to "%biglog%" >>"%log%" 2>&1
echo "%ffmpeg%" -hide_banner -debug mb_type -i "%SRC%" -an -frames:v 6 -f null - ... stderr to "%biglog%" >>"%log%" 2>&1
echo "%ffmpeg%" -hide_banner -debug mb_type -i "%SRC%" -an -frames:v 6 -f null - ... stderr to "%biglog%" >>"%biglog%" 2>&1
"%ffmpeg%" -hide_banner -debug mb_type -i "%SRC%" -an -frames:v 6 -f null - 2>>"%biglog%"
echo.>>"%log%" 2>&1

echo.
echo Wrote "%log%" - open it and look for interlaced / field-DCT macroblock flags
echo Wrote "%biglog%" - CAREFULLY look at sizee and maybe open it and look for interlaced / field-DCT macroblock flags
echo.
echo ================================================================
echo == DONE
echo ================================================================
goto :eof
