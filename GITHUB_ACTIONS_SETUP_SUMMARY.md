# GitHub Actions APK 构建配置 - 总结

## ✅ 已创建的文件

本项目已配置自动化 APK 构建流程，包含以下文件：

### 1. 核心工作流文件

**`.github/workflows/build-apk.yml`** (主构建工作流)
- ✅ 监听 push 和 PR 事件
- ✅ 自动构建 Debug 和 Release APK
- ✅ 上传到 GitHub Artifacts (30天保留)
- ✅ 支持 Release 自动上传

**`.github/workflows/release-apk.yml`** (发布工作流)
- ✅ 监听 Release 事件
- ✅ 构建优化的 Release APK
- ✅ 自动上传到 GitHub Release
- ✅ 生成发布说明

### 2. 配置和文档

**`.github/GITHUB_ACTIONS_README.md`** (完整配置指南)
- 详细的 Secrets 配置说明
- 故障排除指南
- 安全建议
- 进阶配置示例

**`QUICK_START.md`** (快速开始 - 英文)
- 5 分钟快速设置
- 常见问题解答
- 实用技巧

**`QUICK_START_CN.md`** (快速开始 - 中文)
- 5 分钟快速设置
- 常见问题解答
- 实用技巧

### 3. 辅助脚本

**`setup-github-actions.sh`** (Linux/macOS 脚本)
- 自动生成 Base64 编码的 Keystore
- 提供配置步骤指导

**`setup-github-actions.ps1`** (Windows PowerShell 脚本)
- 自动生成 Base64 编码的 Keystore
- 提供配置步骤指导
- 彩色输出提示

---

## 🚀 快速开始（3 步）

### 步骤 1: 运行配置脚本

**Windows (推荐):**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux:**
```bash
bash setup-github-actions.sh
```

脚本会自动生成 Base64 编码的 Keystore，并保存到 `keystore-base64.txt`

### 步骤 2: 配置 GitHub Secrets

访问 GitHub 仓库 → Settings → Secrets and variables → Actions，添加以下 4 个 Secrets:

```
KEYSTORE_BASE64          = (从脚本生成的 Base64 字符串)
KEYSTORE_PASSWORD        = (你的 Keystore 密码)
KEY_ALIAS                = telegram
KEY_PASSWORD             = (你的密钥密码)
```

### 步骤 3: 推送代码

```bash
git add .github/
git add *.md
git add setup-github-actions.*
git commit -m "Add GitHub Actions APK build automation"
git push origin master
```

完成！工作流会自动运行。进入 GitHub Actions 标签页查看构建进度。

---

## 📋 项目配置检查

本项目已包含以下必要配置：

✅ **gradle.properties**
- APP_VERSION_CODE: 6666
- APP_VERSION_NAME: 12.6.4
- APP_PACKAGE: org.telegram.messenger
- 签名配置: androidkey

✅ **build.gradle**
- compileSdkVersion: 35
- buildToolsVersion: 35.0.0
- NDK Version: 21.4.7075529

✅ **Module 结构**
- TMessagesProj (库模块)
- TMessagesProj_App (应用模块)
- TMessagesProj_AppStandalone (独立应用)
- TMessagesProj_AppTests (测试模块)

---

## 📦 构建输出

### 自动生成的 APK 位置

| 类型 | 路径 | 说明 |
|-----|------|------|
| Debug | `TMessagesProj_App/build/outputs/apk/debug/` | 用于测试 |
| Release | `TMessagesProj_App/build/outputs/apk/release/` | 生产版本 |
| Standalone | `TMessagesProj_AppStandalone/build/outputs/apk/standalone/` | 独立版本 |

### 下载方式

1. **GitHub Artifacts** (临时)
   - 进入 Actions → 最近的工作流运行
   - 下载 `debug-apk` 或 `release-apk` 文件夹
   - 保留期: 30-90 天

2. **GitHub Release** (长期)
   - 进入 Releases 页面
   - 下载关联的 APK 文件
   - 永久保存

---

## 🔄 工作流触发方式

### 自动触发

| 事件 | 触发工作流 |
|-----|----------|
| Push 到 master/main/develop | build-apk.yml |
| 创建 Pull Request | build-apk.yml |
| 发布 Release | release-apk.yml |

### 手动触发

1. 进入 GitHub 仓库 → **Actions** 标签页
2. 选择工作流名称
3. 点击 **Run workflow**
4. 选择分支，点击 **Run**

---

## 🔐 安全注意事项

⚠️ **重要!**

1. **不要**将 Keystore 文件上传到 Git
2. **不要**在代码中硬编码密码
3. **使用** GitHub Secrets 存储敏感信息
4. **定期**审计 Actions 日志
5. **备份** Keystore 文件到安全位置

### Keystore 文件保护

```bash
# 添加到 .gitignore
echo "TMessagesProj/config/release.keystore" >> .gitignore
git add .gitignore
git commit -m "Ignore keystore file"
```

---

## 🛠️ 常见问题

### Q: 没有 Keystore，能否构建 Debug APK？
**A:** 可以。脚本会自动使用默认 Debug 签名。Release APK 需要 Keystore。

### Q: 构建失败怎么办？
**A:** 
1. 检查 GitHub Actions 日志
2. 查看 ".github/GITHUB_ACTIONS_README.md" 的故障排除部分
3. 确认所有 Secrets 正确配置

### Q: 如何更新 APK 版本号？
**A:** 修改 `gradle.properties` 中的 `APP_VERSION_CODE` 和 `APP_VERSION_NAME`

### Q: 可以同时构建多个变体吗？
**A:** 可以。修改工作流文件中的 build 命令，例如：
```yaml
./gradlew assembleDebug assembleRelease
```

### Q: APK 在哪里下载？
**A:** 两个地方：
- GitHub Actions → Artifacts (临时)
- GitHub Releases (长期)

---

## 📚 文件导航

```
项目根目录
├── .github/
│   ├── workflows/
│   │   ├── build-apk.yml          ← 主构建工作流
│   │   └── release-apk.yml        ← 发布工作流
│   └── GITHUB_ACTIONS_README.md   ← 完整配置指南
├── setup-github-actions.sh        ← Linux/macOS 配置脚本
├── setup-github-actions.ps1       ← Windows 配置脚本
├── QUICK_START.md                 ← 快速开始（英文）
├── QUICK_START_CN.md              ← 快速开始（中文）
└── gradle.properties              ← 已配置好的构建属性
```

---

## 🎯 下一步

1. ✅ 运行配置脚本（选择对应的操作系统版本）
2. ✅ 配置 GitHub Secrets
3. ✅ 推送代码到 GitHub
4. ✅ 监听第一个构建
5. ✅ 下载和测试 APK
6. ✅ 设置发布流程（可选）

---

## 📞 支持

如有问题，请：

1. 查看详细配置指南: `.github/GITHUB_ACTIONS_README.md`
2. 检查工作流日志: GitHub Actions 页面
3. 查看故障排除部分
4. 参考 GitHub 官方文档

---

**配置日期**: 2024 年  
**工作流状态**: ✅ 就绪  
**APK 构建**: ✅ 已启用  
**自动上传**: ✅ 已启用  

🎉 **你的项目已准备好进行自动化 APK 构建！**
