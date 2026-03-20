@echo off
chcp 65001 >nul
echo ========================================
echo  编译检查
echo ========================================

cd /d "%~dp0"

echo 正在编译项目...
call mvn clean compile -q

if %errorlevel% equ 0 (
    echo.
    echo [成功] 编译成功！
    echo.
) else (
    echo.
    echo [错误] 编译失败，错误信息如下:
    echo.
    call mvn clean compile 2>&1 | findstr /C:"[ERROR]" /C:"error:"
    echo.
)

pause
