@echo off
chcp 65001 >nul
echo ========================================
echo  企业人事管理系统 - 数据库初始化脚本
echo ========================================
echo.

set MYSQL_USER=root
set MYSQL_PASS=1234
set DB_NAME=hrms_db

echo [1/3] 正在连接 MySQL 并创建数据库...
mysql -u%MYSQL_USER% -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME% CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
if %errorlevel% neq 0 (
    echo [错误] 连接 MySQL 失败，请检查用户名和密码
    pause
    exit /b 1
)
echo [成功] 数据库创建完成
echo.

echo [2/3] 正在执行初始化 SQL 脚本...
mysql -u%MYSQL_USER% -p%MYSQL_PASS% %DB_NAME% < "src\main\resources\db\init.sql"
if %errorlevel% neq 0 (
    echo [错误] SQL 执行失败
    pause
    exit /b 1
)
echo [成功] 数据库表和数据初始化完成
echo.

echo [3/3] 验证数据...
mysql -u%MYSQL_USER% -p%MYSQL_PASS% %DB_NAME% -e "SELECT '部门数量' as item, COUNT(*) as count FROM hr_department UNION ALL SELECT '职位数量', COUNT(*) FROM hr_position UNION ALL SELECT '员工数量', COUNT(*) FROM hr_employee UNION ALL SELECT '用户数量', COUNT(*) FROM sys_user;"
echo.

echo ========================================
echo  数据库初始化完成！
echo  数据库名: %DB_NAME%
echo  默认用户: user / user
echo ========================================
pause
