@echo off
set prog=%1
set platform=%2

Rem  Windows batch file to build a test Smokeview for Windows 64

Rem setup environment variables (defining where repository resides etc) 

set envfile="%userprofile%"\fds_smv_env.bat
IF EXIST %envfile% GOTO endif_envexist
echo ***Fatal error.  The environment setup file %envfile% does not exist. 
echo Create a file named %envfile% and use SMV/scripts/fds_smv_env_template.bat
echo as an example.
echo.
echo Aborting now...
pause>NUL
goto:eof

:endif_envexist

call %envfile%
echo.
echo  Building %prog% for 64 bit %platform%
Title Building %prog% for 64 bit %platform%

%svn_drive%


if "%platform%" == "windows" (
  cd %svn_root%\SMV\Build\%prog%\intel_win_64
  call make_%prog% %type%
  goto eof
)
if "%platform%" == "linux" (
  plink %linux_logon% %linux_svn_root%/SMV/scripts/run_command.sh SMV/Build/%prog%/intel_linux_64 make_%prog%.sh 
  goto eof
)
if "%platform%" == "osx" (
  plink %osx_logon% %linux_svn_root%/SMV/scripts/run_command.sh SMV/Build/%prog%/intel_osx_64 make_%prog%.sh
  goto eof
)

:eof
echo.
echo compilation complete
pause
