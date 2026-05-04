# GitHub Actions APK 构建配置

## 快速开始

### 1. 运行配置脚本

**Windows:**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux:**
```bash
bash setup-github-actions.sh
```

### 2. 配置 GitHub Secrets

访问: GitHub Repository → Settings → Secrets and variables → Actions

添加以下 Secrets:
- `KEYSTORE_BASE64` = 从脚本生成的 Base64
- `KEYSTORE_PASSWORD` = 你的 Keystore 密码
- `KEY_ALIAS` = `telegram`
- `KEY_PASSWORD` = 你的密钥密码

### 3. 推送代码

```bash
git add .github/
git commit -m "Add GitHub Actions"
git push origin master
```

## 工作流

| 文件 | 触发条件 | 输出 |
|-----|---------|------|
| build-apk.yml | Push/PR 到 master | Debug/Release APK |
| release-apk.yml | 创建 Release | 附加到 Release |

## 下载 APK

- **临时**: Actions → Artifacts (30天)
- **长期**: GitHub Releases (永久)

## 故障排除

**签名失败**: 检查 Secrets 是否正确  
**APK 找不到**: 查看构建日志中的错误  
**权限错误**: 确保 gradlew 有执行权限（自动处理）

更多帮助查看: START_HERE.md
