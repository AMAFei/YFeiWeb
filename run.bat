@echo off
chcp 65001 >nul
echo ========================================
echo  企业人事管理系统 - 启动脚本
echo ========================================
echo.

echo [INFO] 正在启动企业人事管理系统...

cd /d "%~dp0"

echo [INFO] 编译项目...
call mvn clean compile

if %errorlevel% neq 0 (
    echo [错误] 编译失败，请检查是否已安装 Maven
    pause
    exit /b 1
)

echo.
echo [INFO] 编译成功，正在启动服务...
echo.
echo [提示] 首次启动会自动创建数据库和初始化数据
echo.

call mvn spring-boot:run

pause
