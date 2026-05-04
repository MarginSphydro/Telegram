#!/usr/bin/env pwsh

# GitHub Actions Keystore 配置辅助脚本 (Windows PowerShell)
# 用于生成 Base64 编码的 Keystore 并配置 GitHub Secrets

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "GitHub Actions Keystore 配置助手 (Windows)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Keystore 文件
$keystorePath = "TMessagesProj\config\release.keystore"

if (-not (Test-Path $keystorePath)) {
    Write-Host "❌ 错误: 找不到 Keystore 文件: $keystorePath" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先创建 Keystore 文件:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "keytool -genkey -v -keystore $keystorePath \`" -ForegroundColor Gray
    Write-Host "    -keyalg RSA -keysize 2048 -validity 10000 \`" -ForegroundColor Gray
    Write-Host "    -alias telegram \`" -ForegroundColor Gray
    Write-Host "    -keypass android \`" -ForegroundColor Gray
    Write-Host "    -storepass android" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

# 生成 Base64 编码
Write-Host "📄 正在生成 Base64 编码的 Keystore..." -ForegroundColor Yellow
$keystoreContent = [IO.File]::ReadAllBytes($keystorePath)
$base64Keystore = [Convert]::ToBase64String($keystoreContent)

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ Keystore 配置值" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "以下是需要在 GitHub 中配置的 Secrets:" -ForegroundColor White
Write-Host ""

Write-Host "1️⃣  Secret 名称: KEYSTORE_BASE64" -ForegroundColor Yellow
Write-Host "   值 (前100字符):" -ForegroundColor Gray
Write-Host "   $($base64Keystore.Substring(0, [Math]::Min(100, $base64Keystore.Length)))..." -ForegroundColor Gray
Write-Host ""

Write-Host "2️⃣  Secret 名称: KEYSTORE_PASSWORD" -ForegroundColor Yellow
Write-Host "   值: (请输入你的 Keystore 密码)" -ForegroundColor Gray
Write-Host ""

Write-Host "3️⃣  Secret 名称: KEY_ALIAS" -ForegroundColor Yellow
Write-Host "   值: telegram" -ForegroundColor Gray
Write-Host ""

Write-Host "4️⃣  Secret 名称: KEY_PASSWORD" -ForegroundColor Yellow
Write-Host "   值: (请输入你的密钥密码)" -ForegroundColor Gray
Write-Host ""

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 保存 Base64 到文件以便复制
$base64Keystore | Out-File -FilePath "keystore-base64.txt" -Encoding UTF8
Write-Host "✅ Base64 已保存到文件: keystore-base64.txt" -ForegroundColor Green
Write-Host "   请打开此文件并复制内容到 GitHub Secrets" -ForegroundColor Gray
Write-Host ""

# 尝试复制到剪贴板
try {
    $base64Keystore | Set-Clipboard
    Write-Host "📋 Base64 Keystore 已复制到剪贴板 (Windows)" -ForegroundColor Green
    Write-Host ""
}
catch {
    Write-Host "⚠️  无法复制到剪贴板，请手动复制 keystore-base64.txt 的内容" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "📋 配置步骤:" -ForegroundColor Cyan
Write-Host "1. 访问 GitHub 仓库设置: Settings → Secrets and variables → Actions" -ForegroundColor White
Write-Host "2. 点击 'New repository secret'" -ForegroundColor White
Write-Host "3. 按照上面的列表添加 4 个 Secrets" -ForegroundColor White
Write-Host "4. 推送代码到 GitHub" -ForegroundColor White
Write-Host "5. 在 Actions 标签页查看构建进度" -ForegroundColor White
Write-Host ""

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 gradle.properties
$gradlePropsPath = "gradle.properties"
if (Test-Path $gradlePropsPath) {
    $content = Get-Content $gradlePropsPath
    if ($content -match "APP_PACKAGE") {
        Write-Host "✅ 已检测到 gradle.properties 中的 APP_PACKAGE 配置" -ForegroundColor Green
    }
    else {
        Write-Host "⚠️  警告: gradle.properties 中未找到 APP_PACKAGE" -ForegroundColor Yellow
        Write-Host "   请确保添加: APP_PACKAGE=org.telegram.messenger" -ForegroundColor Yellow
        Write-Host ""
    }
}
else {
    Write-Host "⚠️  未找到 gradle.properties 文件" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 配置完成!" -ForegroundColor Green
Write-Host ""

# 显示文件位置
Write-Host "📁 重要文件位置:" -ForegroundColor Cyan
Write-Host "  • Keystore Base64:     keystore-base64.txt" -ForegroundColor Gray
Write-Host "  • 工作流配置:          .github/workflows/" -ForegroundColor Gray
Write-Host "  • 配置说明:            .github/GITHUB_ACTIONS_README.md" -ForegroundColor Gray
Write-Host ""
