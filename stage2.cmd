@echo off

powershell -c "Invoke-WebRequest -Uri 'http://ipv4.download.thinkbroadband.com/5MB.zip' -OutFile 'poc.zip'"
