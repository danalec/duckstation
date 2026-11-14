@echo off
setlocal enabledelayedexpansion

PUSHD "%~dp0"
FOR /F "tokens=1-3 delims=.-" %%a IN ('git describe --dirty') DO (
  SET "MAJOR=%%a"
  IF /I "!MAJOR:~0,1!"=="v" SET "MAJOR=!MAJOR:~1!"
  FOR %%f IN (duckstation-qt installer uninstaller) DO (
    powershell -NoProfile -Command ^
      "$file = '..\%%f\%%f.rc';" ^
      "(Get-Content $file) -replace '\b\d+,\d+,\d+,\d+\b', '!MAJOR!,%%b,%%c,0' -replace '\b\d+\.\d+\.\d+(?:\.\d+)?\b', '!MAJOR!.%%b.%%c' | Set-Content -Encoding ASCII $file"
  )
)
POPD
