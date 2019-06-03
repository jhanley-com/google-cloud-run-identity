@if not exist service.tmp call get_url.bat

set /p URL=< service.tmp
echo URL: %URL%

curl -I %URL% -w "\nTime to First Byte: %%{time_starttransfer}\n"
