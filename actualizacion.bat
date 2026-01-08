@echo off
setlocal enabledelayedexpansion

:: Carpeta base del proyecto
cd "C:\Users\mvs92\OneDrive\Escritorio\Mi_Negocio"

:: Actualizar todo (incluye borrados)
git add -A
git commit -m "Actualización completa del proyecto"
git push

echo ✅ Proyecto sincronizado con GitHub Pages.
pause