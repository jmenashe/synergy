@echo off

python hm.py %*

copy bin\Release\synergy.exe "C:\Program Files (x86)\Synergy\synergy.exe"

exit /b %errorlevel%
