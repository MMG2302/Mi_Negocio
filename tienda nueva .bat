@echo off
setlocal enabledelayedexpansion

:: Pedir nombre de la tienda
set /p tienda=Escribe el nombre de la tienda: 

:: Carpeta destino dentro del repo
set carpeta=%tienda%
mkdir %carpeta%

:: Copiar archivo base
copy tienda.txt %carpeta%\index.html

:: Reemplazar "MI NEGOCIO" por el nombre de la tienda
powershell -Command "(Get-Content %carpeta%\index.html) -replace 'MI NEGOCIO', '%tienda%' | Set-Content %carpeta%\index.html"

:: Git add/commit/push
git add %carpeta%
git commit -m "Nueva tienda: %tienda%"
git push

echo ✅ Tienda %tienda% creada y subida a GitHub Pages.
pause