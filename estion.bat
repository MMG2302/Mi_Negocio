@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

cls
echo ================================
echo   CONTROL DE CLIENTES (30 dias)
echo ================================

del pendientes.txt 2>nul

for /f "tokens=1,2,3 delims=|" %%a in (clientes.txt) do (
    set nombre=%%a
    set fecha=%%b
    set link=%%c

    set nombre=!nombre: =!
    set fecha=!fecha: =!
    set link=!link: =!

    :: Calcular diferencia de dias con formato MM.dd.yyyy
    for /f %%d in ('powershell -NoProfile -Command "(New-TimeSpan -Start ([datetime]::ParseExact('!fecha!','MM.dd.yyyy',$null)) -End (Get-Date)).Days"') do set dias=%%d

    if !dias! LSS 30 (
        set estado=✅ Vigente
    ) else (
        set estado=⚠ Pendiente/Renovar
        echo !nombre! ^| !link! >> pendientes.txt
    )

    echo Cliente: !nombre!
    echo Alta: !fecha!
    echo Dias transcurridos: !dias!
    echo Estado: !estado!
    echo Link: !link!
    echo -------------------------------
)

echo ============================================
echo Reporte generado.  
echo Los clientes vencidos se guardaron en "pendientes.txt"
echo ============================================

pause