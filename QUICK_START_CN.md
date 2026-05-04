# 🚀 快速开始 - GitHub Actions APK 构建

## ⚡ 5 分钟快速配置

### 第 1 步: 推送代码到 GitHub

```bash
git add .github/
git commit -m "Add GitHub Actions APK build workflow"
git push origin master
```

### 第 2 步: 运行配置脚本

**Windows (PowerShell):**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux (Bash):**
```bash
bash setup-github-actions.sh
```

### 第 3 步: 配置 GitHub Secrets

1. 打开 GitHub 仓库 → **Settings**
2. 左侧菜单 → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 添加以下 Secrets:

| 名称 | 值 |
|-----|---|
| `KEYSTORE_BASE64` | 从脚本输出中复制 |
| `KEYSTORE_PASSWORD` | 你的 Keystore 密码 |
| `KEY_ALIAS` | `telegram` |
| `KEY_PASSWORD` | 你的密钥密码 |

### 第 4 步: 完成！

推送代码后，工作流会自动运行：
- 进入 GitHub 仓库 → **Actions** 标签页
- 查看构建进度
- 等待完成后下载 APK

---

## 📦 构建输出

### Debug APK
- **路径**: `TMessagesProj_App/build/outputs/apk/debug/`
- **下载**: Actions → 工作流 → `debug-apk` Artifact

### Release APK (需要签名)
- **路径**: `TMessagesProj_App/build/outputs/apk/release/`
- **下载**: Actions → 工作流 → `release-apk` Artifact

### Standalone APK
- **路径**: `TMessagesProj_AppStandalone/build/outputs/apk/standalone/`
- **下载**: Actions → 工作流 → `debug-apk` Artifact

---

## 🔄 自动触发条件

工作流会在以下情况自动运行:

| 事件 | 工作流 | 说明 |
|-----|------|------|
| Push 到 `master/main/develop` | build-apk.yml | 自动构建 Debug + Release |
| 创建 Pull Request | build-apk.yml | 自动构建 Debug 版本 |
| 创建 Release | release-apk.yml | 构建并附加到 Release |
| 手动触发 | 任何工作流 | 在 Actions 页面手动运行 |

---

## 🛠️ 故障排除

### ❌ APK 找不到

**检查清单:**
- [ ] `gradle.properties` 中是否配置 `APP_PACKAGE`?
- [ ] 构建日志中是否有错误信息?
- [ ] NDK/SDK 版本是否兼容?

### ❌ 签名失败

**检查清单:**
- [ ] Secrets 是否正确配置?
- [ ] Keystore 密码是否正确?
- [ ] KEY_ALIAS 是否存在于 Keystore?

### ❌ 构建超时

**解决方案:**
- 增加 GitHub Actions 运行时间（最多 6 小时）
- 启用 Gradle 缓存（已配置）
- 移除不必要的构建变体

### ❌ 权限错误

**解决方案:**
- 确保 `gradlew` 有执行权限
- 检查 GitHub Secrets 权限
- 验证 Workflow 文件权限

---

## 📚 更多资源

- 📖 [完整配置指南](.github/GITHUB_ACTIONS_README.md)
- 📖 [GitHub Actions 文档](https://docs.github.com/en/actions)
- 📖 [Android 应用签名](https://developer.android.google.cn/studio/publish/app-signing)

---

## 💡 高级用法

### 创建 Release 并自动附加 APK

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

GitHub 会自动:
1. 创建 Release
2. 构建 APK
3. 附加 APK 到 Release

### 手动触发构建

1. 进入 GitHub 仓库 → **Actions**
2. 选择工作流 (如 "Build and Upload APK")
3. 点击 **Run workflow**
4. 选择分支和选项
5. 点击 **Run workflow**

### 查看构建日志

```bash
# 在 GitHub 网页上查看
Actions → [工作流名称] → [最新运行] → [Build 任务]

# 实时查看完整日志
1. 点击工作流运行
2. 向下滚动查看详细日志
3. 搜索关键词如 "error", "warning"
```

---

## ✨ 最佳实践

1. **定期测试构建** - 至少每周推送一次代码
2. **监控构建日志** - 及时发现问题
3. **备份签名密钥** - 妥善保管 Keystore 文件
4. **使用版本标签** - 便于追踪发布版本
5. **文档更新** - 保持 Secrets 和配置同步

---

**🎉 现在你已经准备好进行自动化构建了！**

有问题? 查看 [完整配置指南](.github/GITHUB_ACTIONS_README.md) 或检查工作流日志。
