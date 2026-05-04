# ✅ GitHub Actions 配置检查清单

## 📋 配置前检查

- [ ] 已将项目推送到 GitHub
- [ ] 拥有仓库的管理员权限
- [ ] 拥有有效的 Keystore 文件（或使用 Debug 签名）
- [ ] 了解 Keystore 密码

## 📁 文件配置检查

### 工作流文件
- [ ] `.github/workflows/build-apk.yml` 存在
- [ ] `.github/workflows/release-apk.yml` 存在
- [ ] 两个文件都有正确的 YAML 格式

### 配置文档
- [ ] `.github/GITHUB_ACTIONS_README.md` 存在
- [ ] `QUICK_START.md` 存在
- [ ] `QUICK_START_CN.md` 存在
- [ ] `GITHUB_ACTIONS_SETUP_SUMMARY.md` 存在

### 辅助脚本
- [ ] `setup-github-actions.sh` 存在
- [ ] `setup-github-actions.ps1` 存在

### 项目配置
- [ ] `gradle.properties` 包含 `APP_PACKAGE`
- [ ] `gradle.properties` 包含 `RELEASE_KEY_ALIAS`
- [ ] `gradle.properties` 包含 `RELEASE_STORE_PASSWORD`
- [ ] `gradle.properties` 包含 `RELEASE_KEY_PASSWORD`

## 🔑 GitHub Secrets 配置检查

### 必需的 Secrets

访问: GitHub → Settings → Secrets and variables → Actions

- [ ] `KEYSTORE_BASE64` - 已添加并复制检查
- [ ] `KEYSTORE_PASSWORD` - 已验证正确
- [ ] `KEY_ALIAS` - 已设置为 `telegram`
- [ ] `KEY_PASSWORD` - 已验证正确

### 可选的 Secrets

- [ ] `FIREBASE_TOKEN` (仅在使用 Firebase Distribution 时)
- [ ] `FIREBASE_SERVICE_ACCOUNT_JSON` (仅在使用 Firebase Distribution 时)

## 🛠️ 本地测试检查

- [ ] 本地能成功运行 `./gradlew assembleDebug`
- [ ] 本地能成功运行 `./gradlew assembleRelease`
- [ ] 本地构建没有错误警告

## 📤 推送代码检查

- [ ] 已执行 `git add .github/`
- [ ] 已执行 `git add *.md`
- [ ] 已执行 `git add setup-github-actions.*`
- [ ] 已执行 `git commit`
- [ ] 已执行 `git push origin master`

## ✅ GitHub Actions 检查

### 首次构建

1. [ ] 进入 GitHub Repository → Actions 标签页
2. [ ] 能看到工作流 "Build and Upload APK"
3. [ ] 工作流已成功运行或正在运行

### 构建结果验证

- [ ] 构建日志中没有 ERROR
- [ ] 能看到 "assembleDebug" 成功消息
- [ ] 能看到 APK 文件路径

### 输出文件检查

- [ ] Artifacts 中能看到 `debug-apk` 文件夹
- [ ] 能下载 APK 文件
- [ ] APK 文件大小正常（> 50MB）

## 📱 APK 安装测试

- [ ] 将 APK 下载到 Android 设备
- [ ] APK 能成功安装
- [ ] 应用能正常启动
- [ ] 应用功能正常

## 🔐 安全检查

- [ ] `.gitignore` 包含 `release.keystore`
- [ ] 没有在代码中硬编码密码
- [ ] 没有在 git 历史中泄露密钥
- [ ] GitHub Secrets 权限设置正确

## 📊 持续集成检查

### 代码变更检查

- [ ] 修改代码并推送
- [ ] Actions 自动触发构建
- [ ] 新构建成功完成

### PR 检查

- [ ] 创建 PR 到 master 分支
- [ ] Actions 自动运行检查
- [ ] PR 状态显示检查成功

### Release 检查

- [ ] 创建一个 Release
- [ ] `release-apk.yml` 工作流自动触发
- [ ] Release 中自动附加了 APK 文件

## 🔧 常见问题检查

### 如果构建失败

- [ ] 查看工作流日志中的错误信息
- [ ] 检查 NDK/SDK 版本兼容性
- [ ] 验证 Keystore 配置
- [ ] 查看 ".github/GITHUB_ACTIONS_README.md" 的故障排除部分

### 如果找不到 APK

- [ ] 检查构建是否成功完成
- [ ] 查看工作流日志中的 "Find APK files" 步骤
- [ ] 验证 build.gradle 中的输出路径配置

### 如果签名失败

- [ ] 验证 Secrets 配置正确
- [ ] 确认 Keystore 密码与 Secret 一致
- [ ] 检查 KEY_ALIAS 是否存在于 Keystore

## 📈 性能优化检查

- [ ] Gradle 缓存已启用（自动）
- [ ] JDK 版本为 17（推荐）
- [ ] NDK 版本与项目匹配

## 📚 文档完整性检查

- [ ] 所有配置文档都已创建
- [ ] 所有文档内容清晰易懂
- [ ] 包含中文和英文文档
- [ ] 包含故障排除指南

## 🎯 最终检查

### 工作流就绪检查表

- [ ] 所有必需文件已创建
- [ ] GitHub Secrets 已配置
- [ ] 至少运行过一次成功构建
- [ ] 能成功下载 APK
- [ ] 团队成员了解如何使用

### 文档完整性

- [ ] 快速开始指南已阅读
- [ ] 完整配置指南可用
- [ ] 故障排除部分已准备
- [ ] 团队已获知新工作流

## 🚀 准备就绪

全部检查完成后，标记此项:

- [ ] **GitHub Actions APK 自动构建系统已就绪！** 🎉

---

## 📝 检查清单使用方法

1. **打印此文件** 并在完成每项时打勾
2. **保存此文件** 作为项目文档
3. **与团队分享** 确保所有人都知道进度
4. **定期审查** 确保配置始终正确

---

**检查日期**: ________________  
**检查人员**: ________________  
**状态**: ⏳ 进行中 / ✅ 完成 / ❌ 需要帮助

---

## 🆘 需要帮助？

如果任何项目无法完成，请：

1. 查看对应的配置文档
2. 检查工作流日志
3. 参考故障排除指南
4. 检查 GitHub Actions 官方文档

**祝你的 CI/CD 流程顺利！** 🚀
