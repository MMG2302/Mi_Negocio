@echo off
setlocal enabledelayedexpansion

:: Configura tu usuario y repo en GitHub
set usuario=MMG2302
set repo=Mi_Negocio

:menu
cls
echo ================================
echo   SISTEMA DE TIENDAS - POS SaaS
echo ================================
echo 1. Crear nueva tienda
echo 2. Eliminar tienda
echo 3. Sincronizar todo
echo 4. Salir
echo ================================
set /p opcion=Elige una opcion: 

if "%opcion%"=="1" goto crear
if "%opcion%"=="2" goto eliminar
if "%opcion%"=="3" goto sync
if "%opcion%"=="4" exit
goto menu

:crear
set /p tienda=Escribe el nombre de la tienda: 

:: Carpeta segura (sin espacios)
set carpeta=%tienda%
set carpeta=%carpeta: =_%

mkdir "%carpeta%"
copy tienda.txt "%carpeta%\index.html"

:: Reemplazar titulo en HTML
powershell -Command "(Get-Content '%carpeta%\index.html') -replace 'MI NEGOCIO', '%tienda%' | Set-Content '%carpeta%\index.html'"

:: Git
git add "%carpeta%"
git commit -m "Nueva tienda: %tienda%"
git push

:: Construir link
set link=https://%usuario%.github.io/%repo%/%carpeta%/

:: Guardar registro
echo %tienda% ^| %date% ^| %link% >> clientes.txt

echo.
echo ============================================
echo ✅ Tienda "%tienda%" creada en carpeta "%carpeta%"
echo 🌐 Link para compartir: %link%
echo ============================================
echo.
pause
goto menu

:eliminar
set /p tienda=Nombre de la tienda a eliminar: 
set carpeta=%tienda%
set carpeta=%carpeta: =_%

rmdir /s /q "%carpeta%"

git add -A
git commit -m "Eliminar tienda: %tienda%"
git push

echo.
echo ❌ Tienda "%tienda%" eliminada.
echo.
pause
goto menu

:sync
git add -A
git commit -m "Sincronizacion completa"
git push
echo.
echo 🔄 Repo sincronizado con carpeta local.
echo.
pause
goto menu