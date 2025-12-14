@echo off
chcp 65001 >nul

:: =============== 配置区 ===============
set "NOTE_DIR=C:\Users\YeLi\Desktop\JUC-Study"
set "COMMIT_MSG=Update notes - %date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%"
:: ======================================

cd /d "%NOTE_DIR%" || (
    echo 错误：无法进入目录 %NOTE_DIR%
    pause
    exit /b 1
)

echo 正在检查 Git 状态...
git status --porcelain >nul
if errorlevel 1 (
    echo 没有更改，无需提交。
    goto :push
)

echo 正在添加文件...
git add .

echo 正在提交更改...
git commit -m "%COMMIT_MSG%"

:push
echo 正在推送至 GitHub...
git push origin main

if errorlevel 1 (
    echo 推送失败，请检查网络或认证配置。
) else (
    echo ✅ 提交并推送成功！
)

pause