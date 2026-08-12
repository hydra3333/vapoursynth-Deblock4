@echo off
@setlocal ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

set "ffmpeg=C:\SOFTWARE\ffmpeg\ffmpeg.exe"

REM use -q:v 31 to get some blockiness
REM ffmpeg -i input.mpg -c:v mpeg2video -qscale:v 31 -flags +ilme+ildct -top 1 -g 12 -bf 2 output.mpg

REM D:\VHS\home_576p.mpg
REM D:\VHS\A001.VOB
REM D:\VHS\A002.VOB

call :make_blocky "D:\VHS\A001.mpg"
call :make_blocky "D:\VHS\A002.mpg"
call :make_blocky "D:\VHS\A003-TRIMMED.mpg"
call :make_blocky "D:\VHS\home_576i.mpg"
call :make_blocky "D:\VHS\LG_576i_1_XP.mpg"
call :make_blocky "D:\VHS\LG_576i_2_SP.mpg"
call :make_blocky "D:\VHS\LG_576i_3_LP.mpg"
call :make_blocky "D:\VHS\LG_576i_4_EP.mpg"
call :make_blocky "D:\VHS\LG_576i_5_MLS.mpg"

pause
goto :eof

:make_blocky
REM
REM For the -field_order option in FFmpeg, the valid parameters are:
REM     tt : Top Field First TFF. This is the standard for most interlaced formats, including PAL DVDs and HD broadcasts.
REM     bb : Bottom Field First BFF. This is commonly used for DV Digital Video tape formats and some NTSC SD content.
REM     progressive : Progressive scan non-interlaced.
REM
set "inp=%~dpnx1"
set "out=%~dpn1_blocky%~x1"
echo.
echo Input : "%inp%"
echo Output: "%out%"
@echo on
"%ffmpeg%" -i "%inp%" -c:v mpeg2video -qscale:v 31 -flags +ilme+ildct -field_order tt -g 12 -bf 2 -y "%out%"
REM "%ffmpeg%" -i "%inp%" -c:v mpeg2video -b:v 1300k -maxrate:v 1400k -bufsize:v 1300k -flags +ilme+ildct -field_order tt -g 12 -bf 2 -y "%out%"
@echo off
echo.
goto :eof

