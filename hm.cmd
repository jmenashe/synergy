@echo off

python hm.py %*

copy bin\Release\synergy.exe "C:\Program Files (x86)\Synergy\synergy.exe"
copy bin\Release\synergyc.exe "C:\Program Files (x86)\Synergy\synergyc.exe"
copy bin\Release\synergys.exe "C:\Program Files (x86)\Synergy\synergys.exe"

exit /b %errorlevel%
