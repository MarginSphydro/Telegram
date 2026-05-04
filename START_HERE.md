# 🎯 立即开始使用

## 快速命令（复制粘贴）

### Windows (PowerShell)

```powershell
# 1. 运行配置脚本
.\setup-github-actions.ps1

# 2. 复制 Base64 Keystore（从脚本输出或从 keystore-base64.txt）
# 3. 在 GitHub 配置 Secrets (见下面的说明)

# 4. 推送代码到 GitHub
git add .github/
git add *.md
git add setup-github-actions.*
git commit -m "Add GitHub Actions APK build automation"
git push origin master
```

### macOS / Linux (Bash)

```bash
# 1. 运行配置脚本
bash setup-github-actions.sh

# 2. 复制 Base64 Keystore（从脚本输出或从 keystore-base64.txt）
# 3. 在 GitHub 配置 Secrets (见下面的说明)

# 4. 推送代码到 GitHub
git add .github/
git add *.md
git add setup-github-actions.*
git commit -m "Add GitHub Actions APK build automation"
git push origin master
```

---

## GitHub Secrets 配置

访问: **https://github.com/你的用户名/你的仓库/settings/secrets/actions**

点击 **New repository secret** 并添加以下 4 个 Secrets:

### Secret 1: KEYSTORE_BASE64
```
Name: KEYSTORE_BASE64
Value: [从脚本输出复制]
```

### Secret 2: KEYSTORE_PASSWORD
```
Name: KEYSTORE_PASSWORD
Value: [你的 Keystore 密码，如 android]
```

### Secret 3: KEY_ALIAS
```
Name: KEY_ALIAS
Value: telegram
```

### Secret 4: KEY_PASSWORD
```
Name: KEY_PASSWORD
Value: [你的密钥密码，如 android]
```

---

## 推送代码后

1. 进入 GitHub 仓库 → **Actions** 标签页
2. 查看 "Build and Upload APK" 工作流
3. 等待构建完成（通常需要 15-20 分钟）
4. 下载生成的 APK 文件

---

## 查看详细文档

- **快速开始** (5分钟): `QUICK_START.md`
- **中文快速开始** (5分钟): `QUICK_START_CN.md`
- **完整配置指南** (20分钟): `.github/GITHUB_ACTIONS_README.md`
- **全面总结** (10分钟): `COMPLETE_SETUP_GUIDE.md`
- **检查清单**: `SETUP_CHECKLIST.md`

---

## 常见问题 - 快速解答

**Q: 没有 Keystore 可以构建吗?**  
A: 可以。将使用默认 Debug 签名构建。

**Q: 构建需要多长时间?**  
A: 第一次构建通常需要 15-20 分钟。之后由于缓存会快一些。

**Q: APK 在哪里下载?**  
A: 两个地方: Artifacts (临时) 或 Releases (长期)

**Q: 可以手动触发构建吗?**  
A: 可以。在 Actions 页面选择工作流并点击 "Run workflow"

---

## 下一步

✅ 运行配置脚本  
✅ 配置 GitHub Secrets  
✅ 推送代码  
✅ 检查第一个构建  
✅ 下载并测试 APK  

---

**需要帮助?** 查看 `QUICK_START.md` 或完整指南。

🚀 **开始你的自动化构建之旅！**
