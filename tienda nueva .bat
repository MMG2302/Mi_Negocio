@echo off
setlocal enabledelayedexpansion

:: Pedir nombre de la tienda
set /p tienda=Escribe el nombre de la tienda: 

:: Crear nombre seguro para carpeta (reemplaza espacios por guiones bajos)
set carpeta=%tienda%
set carpeta=%carpeta: =_%

:: Carpeta destino dentro del repo
mkdir "%carpeta%"

:: Copiar archivo base
copy tienda.txt "%carpeta%\index.html"

:: Reemplazar "MI NEGOCIO" por el nombre original de la tienda en el HTML
powershell -Command "(Get-Content '%carpeta%\index.html') -replace 'MI NEGOCIO', '%tienda%' | Set-Content '%carpeta%\index.html'"

:: Git add/commit/push
git add "%carpeta%"
git commit -m "Nueva tienda: %tienda%"
git push

echo ✅ Tienda %tienda% creada en carpeta %carpeta% y subida a GitHub Pages.
pause