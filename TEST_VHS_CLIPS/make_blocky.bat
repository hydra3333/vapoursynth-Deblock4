@echo off
@setlocal ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

set "ffmpeg=C:\SOFTWARE\ffmpeg\ffmpeg.exe"

REM use -q:v 31 to get some blockiness
REM ffmpeg -i input.mpg -c:v mpeg2video -qscale:v 31 -flags +ilme+ildct -top 1 -g 12 -bf 2 output.mpg

call :make_blocky "D:\VHS\TEST_1A_LG_576i_1_XP.mpg"
call :make_blocky "D:\VHS\TEST_2A_A001.mpg"
call :make_blocky "D:\VHS\TEST_3A_A002.mpg"
call :make_blocky "D:\VHS\TEST_4A_A003.mpg"
call :make_blocky "D:\VHS\TEST_5A_home_576i.mpg"
call :make_blocky "D:\VHS\TEST_6A_home_576i.mpg"
call :make_blocky "D:\VHS\TEST_7A_home_576i.mpg"

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

