#!/bin/bash

# GitHub Actions Keystore 配置辅助脚本
# 用于生成 Base64 编码的 Keystore 并配置 GitHub Secrets

set -e

echo "=========================================="
echo "GitHub Actions Keystore 配置助手"
echo "=========================================="
echo ""

# 检查 Keystore 文件
KEYSTORE_PATH="TMessagesProj/config/release.keystore"

if [ ! -f "$KEYSTORE_PATH" ]; then
    echo "❌ 错误: 找不到 Keystore 文件: $KEYSTORE_PATH"
    echo ""
    echo "请先创建 Keystore 文件:"
    echo ""
    echo "$ keytool -genkey -v -keystore $KEYSTORE_PATH \\"
    echo "    -keyalg RSA -keysize 2048 -validity 10000 \\"
    echo "    -alias telegram \\"
    echo "    -keypass android \\"
    echo "    -storepass android"
    echo ""
    exit 1
fi

# 生成 Base64 编码
echo "📄 正在生成 Base64 编码的 Keystore..."
BASE64_KEYSTORE=$(cat "$KEYSTORE_PATH" | base64 -w 0)

echo ""
echo "=========================================="
echo "✅ Keystore 配置值"
echo "=========================================="
echo ""
echo "以下是需要在 GitHub 中配置的 Secrets:"
echo ""
echo "1️⃣  Secret 名称: KEYSTORE_BASE64"
echo "   值 (太长，已截断):"
echo "   ${BASE64_KEYSTORE:0:100}..."
echo ""
echo "2️⃣  Secret 名称: KEYSTORE_PASSWORD"
echo "   值: (请输入你的 Keystore 密码)"
echo ""
echo "3️⃣  Secret 名称: KEY_ALIAS"
echo "   值: telegram"
echo ""
echo "4️⃣  Secret 名称: KEY_PASSWORD"
echo "   值: (请输入你的密钥密码)"
echo ""
echo "=========================================="
echo ""

# 提供复制选项
if command -v pbcopy &> /dev/null; then
    # macOS
    echo "$BASE64_KEYSTORE" | pbcopy
    echo "✅ Base64 Keystore 已复制到剪贴板 (macOS)"
elif command -v xclip &> /dev/null; then
    # Linux with xclip
    echo "$BASE64_KEYSTORE" | xclip -selection clipboard
    echo "✅ Base64 Keystore 已复制到剪贴板 (Linux)"
elif command -v xsel &> /dev/null; then
    # Linux with xsel
    echo "$BASE64_KEYSTORE" | xsel --clipboard --input
    echo "✅ Base64 Keystore 已复制到剪贴板 (Linux)"
else
    # 其他系统，保存到文件
    echo "$BASE64_KEYSTORE" > keystore-base64.txt
    echo "✅ Base64 已保存到 keystore-base64.txt"
    echo "   请手动复制内容到 GitHub Secrets"
fi

echo ""
echo "📋 配置步骤:"
echo "1. 访问 GitHub 仓库设置: Settings → Secrets and variables → Actions"
echo "2. 点击 'New repository secret'"
echo "3. 按照上面的列表添加 4 个 Secrets"
echo "4. 推送代码到 GitHub"
echo "5. 在 Actions 标签页查看构建进度"
echo ""
echo "=========================================="
echo ""

# 检查 gradle.properties
if grep -q "APP_PACKAGE" gradle.properties 2>/dev/null; then
    echo "✅ 已检测到 gradle.properties 中的 APP_PACKAGE 配置"
else
    echo "⚠️  警告: gradle.properties 中未找到 APP_PACKAGE"
    echo "   请确保添加: APP_PACKAGE=org.telegram.messenger"
    echo ""
fi

echo "🎉 配置完成!"
echo ""
