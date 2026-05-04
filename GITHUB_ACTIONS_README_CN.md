# 📱 Telegram APK 自动构建系统

这是一个为 Telegram 项目配置的完整 **GitHub Actions CI/CD 系统**，用于自动构建、签名和发布 APK 应用程序。

## 🎯 功能特性

✅ **自动构建** - 代码 Push 时自动触发构建  
✅ **多平台** - 支持 Debug、Release 和 Standalone 版本  
✅ **自动签名** - 使用 Keystore 进行 APK 签名  
✅ **自动上传** - 上传到 GitHub Artifacts 和 Releases  
✅ **Release 支持** - 创建 Release 时自动附加 APK  
✅ **Firebase 集成** - 可选的 Firebase App Distribution 支持  
✅ **完整文档** - 中英文配置指南和快速开始  

## 📁 项目结构

```
项目根目录/
├── .github/
│   ├── workflows/
│   │   ├── build-apk.yml              # 主要构建工作流（推送时触发）
│   │   └── release-apk.yml            # 发布工作流（Release 时触发）
│   ├── ISSUE_TEMPLATE/
│   │   ├── build-failure.md           # 构建失败报告模板
│   │   └── build-improvement.md       # 改进建议模板
│   └── GITHUB_ACTIONS_README.md       # 详细配置指南
│
├── setup-github-actions.sh            # Linux/macOS 配置脚本
├── setup-github-actions.ps1           # Windows PowerShell 配置脚本
├── QUICK_START.md                     # 快速开始（英文）
├── QUICK_START_CN.md                  # 快速开始（中文）
├── GITHUB_ACTIONS_SETUP_SUMMARY.md    # 配置总结
├── SETUP_CHECKLIST.md                 # 设置检查清单
│
└── [其他项目文件...]
    ├── TMessagesProj/                 # 库模块
    ├── TMessagesProj_App/             # 主应用模块
    ├── TMessagesProj_AppStandalone/   # 独立应用模块
    ├── gradle.properties              # Gradle 配置（已准备好）
    ├── settings.gradle                # Gradle 设置
    └── build.gradle                   # 根 Gradle 配置
```

## 🚀 快速开始

### 1️⃣ 运行配置脚本（5 分钟）

根据你的操作系统选择相应的脚本：

**Windows (PowerShell):**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux (Bash):**
```bash
bash setup-github-actions.sh
```

脚本会自动：
- ✅ 检查 Keystore 文件
- ✅ 生成 Base64 编码
- ✅ 复制到剪贴板（如可用）
- ✅ 保存到文件（如不可用）

### 2️⃣ 配置 GitHub Secrets

访问: **GitHub Repository → Settings → Secrets and variables → Actions**

添加以下 4 个 Secrets:

| Name | Value |
|------|-------|
| `KEYSTORE_BASE64` | 从脚本输出复制 |
| `KEYSTORE_PASSWORD` | 你的 Keystore 密码 |
| `KEY_ALIAS` | `telegram` |
| `KEY_PASSWORD` | 你的密钥密码 |

### 3️⃣ 推送代码

```bash
git add .github/
git add *.md
git add setup-github-actions.*
git commit -m "Add GitHub Actions APK build automation"
git push origin master
```

### ✅ 完成！

工作流会自动运行。进入 **Actions** 标签页查看构建进度。

---

## 📦 构建输出

### APK 文件位置

| 类型 | 位置 | 获取方式 |
|-----|------|---------|
| **Debug APK** | `TMessagesProj_App/build/outputs/apk/debug/` | Actions → Artifacts |
| **Release APK** | `TMessagesProj_App/build/outputs/apk/release/` | Actions → Artifacts |
| **Standalone APK** | `TMessagesProj_AppStandalone/build/outputs/apk/standalone/` | Actions → Artifacts |

### 下载方式

#### 方式 1: GitHub Actions Artifacts (临时)
1. 进入 GitHub Repository → **Actions**
2. 点击最近的工作流运行
3. 下载 Artifacts 文件夹
4. 保留期: 30-90 天

#### 方式 2: GitHub Releases (长期)
1. 创建一个 Git Release: `git tag v1.0.0 && git push origin v1.0.0`
2. GitHub Actions 会自动构建并附加 APK
3. 进入 **Releases** 页面下载
4. 永久保存

---

## 🔄 工作流触发机制

### 自动触发事件

| 事件 | 触发工作流 | 说明 |
|-----|----------|------|
| **Push 到 master/main/develop** | `build-apk.yml` | 自动构建 Debug + Release |
| **创建 Pull Request** | `build-apk.yml` | 自动构建 Debug 版本 |
| **发布 Release** | `release-apk.yml` | 构建并附加到 Release |
| **手动触发** | 任何工作流 | Actions 页面 → Run workflow |

### 手动触发构建

1. 进入 GitHub Repository → **Actions**
2. 选择工作流 (如 "Build and Upload APK")
3. 点击 **Run workflow**
4. 选择分支
5. 点击 **Run workflow**

---

## 🔐 安全和隐私

### ✅ 安全做法

- ✅ 使用 GitHub Secrets 存储敏感信息
- ✅ Keystore 从不提交到 Git
- ✅ Secrets 自动加密
- ✅ 只在需要时解密

### ⚠️ 安全警告

- ❌ 不要在代码中硬编码密码
- ❌ 不要将 Keystore 上传到 Git
- ❌ 不要在日志中打印密钥
- ❌ 定期轮换 Keystore 密码

### .gitignore 配置

确保 `.gitignore` 包含：
```gitignore
# Keystore files
*.keystore
*.jks

# Gradle
.gradle/
build/

# IDE
.idea/
*.iml
```

---

## 📚 文档导航

### 快速参考

| 文件 | 用途 | 时间 |
|-----|------|------|
| **QUICK_START.md** | 英文快速开始 | 5 分钟 |
| **QUICK_START_CN.md** | 中文快速开始 | 5 分钟 |
| **GITHUB_ACTIONS_SETUP_SUMMARY.md** | 配置总结 | 10 分钟 |
| **.github/GITHUB_ACTIONS_README.md** | 完整配置指南 | 20 分钟 |
| **SETUP_CHECKLIST.md** | 检查清单 | 依情况而定 |

### 按场景选择文档

**我想快速上手**
→ 查看 `QUICK_START.md` 或 `QUICK_START_CN.md`

**我想了解详细配置**
→ 查看 `.github/GITHUB_ACTIONS_README.md`

**我想检查是否配置完整**
→ 使用 `SETUP_CHECKLIST.md`

**我遇到构建失败**
→ 查看 `.github/GITHUB_ACTIONS_README.md` 的故障排除部分

**我想参与改进**
→ 提交 Issue 使用 `.github/ISSUE_TEMPLATE/build-improvement.md`

---

## 🛠️ 系统要求

### 硬件
- CPU: 现代多核处理器
- RAM: 至少 8GB（GitHub Actions 环境提供 7GB）
- 磁盘: 至少 10GB 可用空间

### 软件
- Git
- Java 17
- Android SDK (自动由 GitHub Actions 配置)
- NDK 21.4.7075529 (项目配置)

### GitHub
- 有效的 GitHub 账户
- 对仓库的管理员权限
- 有效的 Keystore 文件（可选）

---

## 🎓 学习资源

### GitHub Actions
- [GitHub Actions 官方文档](https://docs.github.com/en/actions)
- [Workflow 语法参考](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [安全最佳实践](https://docs.github.com/en/actions/security-guides)

### Android 开发
- [Android 应用签名](https://developer.android.google.cn/studio/publish/app-signing)
- [Gradle 构建系统](https://developer.android.google.cn/studio/build)
- [APK 打包指南](https://developer.android.google.cn/studio/build/building-cmdline)

### Telegram 项目
- [Telegram 官方 GitHub](https://github.com/DrKLO/Telegram)
- [Telegram 开发文档](https://core.telegram.org/)

---

## 💡 高级用法

### 构建特定变体

编辑 `.github/workflows/build-apk.yml`，修改构建命令：

```yaml
- name: Build specific variants
  run: ./gradlew :TMessagesProj_App:assembleDebug :TMessagesProj_AppStandalone:assembleStandalone
```

### 添加通知

可以添加 Slack、Email 或其他通知服务的步骤。示例 Slack 通知：

```yaml
- name: Send Slack notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
  if: always()
```

### 自动化测试

在构建前添加测试步骤：

```yaml
- name: Run tests
  run: ./gradlew test
```

### 多平台构建

同时为多个架构构建 APK：

```yaml
- name: Build universal APK
  run: ./gradlew bundleRelease
```

---

## 🐛 故障排除

### 常见问题

**问题**: APK 找不到
**解决**: 查看日志中的"Find APK files"步骤，检查 build.gradle 配置

**问题**: 签名失败
**解决**: 验证 Secrets 配置，检查 Keystore 密码

**问题**: 构建超时
**解决**: 启用 Gradle 缓存，移除不必要的变体

**问题**: 权限错误
**解决**: 自动处理，无需手动操作

详见 `.github/GITHUB_ACTIONS_README.md` 的完整故障排除指南。

---

## 📊 项目统计

| 指标 | 值 |
|-----|---|
| **工作流** | 2 个 |
| **步骤** | 15+ 个 |
| **配置文件** | 8+ 个 |
| **文档** | 6+ 个 |
| **脚本** | 2 个 |
| **平台支持** | Windows, macOS, Linux |

---

## 🤝 贡献

欢迎改进此 CI/CD 系统！

### 提交改进

1. Fork 仓库
2. 创建特性分支 (`git checkout -b feature/improvement`)
3. 提交变更 (`git commit -m "Add improvement"`)
4. 推送分支 (`git push origin feature/improvement`)
5. 创建 Pull Request

### 报告问题

使用 `.github/ISSUE_TEMPLATE/build-failure.md` 模板报告问题。

---

## 📝 许可证

This configuration is provided as-is. The Telegram project maintains its own license.

---

## 🎉 开始使用

**你现在已准备好进行自动化 APK 构建了！**

1. ✅ 运行配置脚本
2. ✅ 配置 GitHub Secrets
3. ✅ 推送代码
4. ✅ 等待构建完成
5. ✅ 下载 APK

**祝你构建顺利！** 🚀

---

**最后更新**: 2024 年  
**配置状态**: ✅ 就绪  
**维护者**: GitHub Actions System
