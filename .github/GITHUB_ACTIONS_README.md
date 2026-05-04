# GitHub Actions APK 构建配置指南

这个项目配置了自动构建和上传 APK 的 GitHub Actions 工作流。

## 📁 文件说明

### 1. `.github/workflows/build-apk.yml`
**自动构建工作流** - 在代码推送时自动执行
- 监听分支: `master`, `main`, `develop`
- 构建 Debug 和 Release APK
- 自动上传到 GitHub Artifacts
- 支持 Release 版本自动上传到 GitHub Release

### 2. `.github/workflows/release-apk.yml`
**发布工作流** - 在创建 Release 时执行
- 监听 Release 事件
- 构建优化的 Release APK
- 上传到 GitHub Release
- 生成发布说明

## 🔑 必需的 Secrets 配置

在 GitHub 仓库设置中配置以下 Secrets（Settings → Secrets and variables → Actions）：

### 基础配置（可选）
如果不配置，将使用默认的 Debug 签名构建：

| Secret 名称 | 说明 | 示例 |
|-----------|------|------|
| `KEYSTORE_BASE64` | Keystore 文件的 Base64 编码 | (见下面的生成方法) |
| `KEYSTORE_PASSWORD` | Keystore 密码 | `your_keystore_password` |
| `KEY_ALIAS` | 密钥别名 | `telegram` |
| `KEY_PASSWORD` | 密钥密码 | `your_key_password` |

### Firebase 配置（可选）
用于上传到 Firebase App Distribution：

| Secret 名称 | 说明 |
|-----------|------|
| `FIREBASE_TOKEN` | Firebase CLI 令牌 |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Firebase 服务账户 JSON |

## 🛠️ 如何生成和配置签名密钥

### 方法 1: 使用现有的 release.keystore

如果你已经有 `TMessagesProj/config/release.keystore` 文件：

```bash
# 1. 转换为 Base64
cat TMessagesProj/config/release.keystore | base64 -w 0

# 2. 复制输出的 Base64 字符串
# 3. 在 GitHub 仓库设置中创建名为 KEYSTORE_BASE64 的 Secret，粘贴 Base64 字符串
```

### 方法 2: 创建新的签名密钥

```bash
# 生成新的 keystore 文件
keytool -genkey -v -keystore TMessagesProj/config/release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias telegram \
  -keypass android \
  -storepass android

# 转换为 Base64
cat TMessagesProj/config/release.keystore | base64 -w 0
```

### 方法 3: 从 Windows 生成 Base64

```powershell
# PowerShell
$base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes("TMessagesProj\config\release.keystore"))
Write-Host $base64
```

## 📋 gradle.properties 配置

确保在 `gradle.properties` 中配置了应用包名：

```properties
APP_PACKAGE=org.telegram.messenger
```

## 🚀 工作流触发方式

### 1. **自动触发** (build-apk.yml)
- Push 代码到 `master`, `main`, `develop` 分支
- 提交 Pull Request 到这些分支
- 手动触发 workflow_dispatch

### 2. **发布版本** (release-apk.yml)
- 创建 GitHub Release
- 在 GitHub Actions 中手动选择构建类型

### 3. **手动触发**
在 GitHub 仓库的 Actions 标签页，选择工作流并点击 "Run workflow"

## 📦 输出文件位置

构建完成后，APK 文件可从以下位置获取：

### GitHub Artifacts
- 路径: Actions 工作流 → 点击完成的工作流 → 下载 `debug-apk` 或 `release-apk`
- 保留期: 30 天（Debug），90 天（Release）

### GitHub Releases
- 仅当创建了 Release 或使用 `workflow_dispatch` 且标记为发布时

## 📝 日志查看

1. 进入 GitHub 仓库
2. 点击 "Actions" 标签页
3. 选择工作流运行
4. 点击 "Build" 任务查看详细日志

## 🐛 故障排除

### 问题 1: "找不到 APK 文件"
**原因**: 构建失败或输出路径不正确
**解决方案**: 
- 查看构建日志中的错误
- 确保 `gradle.properties` 中配置了 `APP_PACKAGE`
- 检查 Keystore 配置是否正确

### 问题 2: "签名失败"
**原因**: Keystore 密码不正确或 Secret 配置有误
**解决方案**:
- 验证 Secret 值是否正确
- 确保密码对应正确的 Keystore 和密钥别名
- 尝试用 Debug 签名构建（不配置 Keystore Secrets）

### 问题 3: "构建超时"
**原因**: 首次构建或大型项目构建时间过长
**解决方案**:
- GitHub Actions 有 6 小时超时限制
- 启用 Gradle 缓存以加快构建（已配置）
- 考虑并行构建多个变体

### 问题 4: "权限错误"
**原因**: gradlew 缺少执行权限
**解决方案**: 已在工作流中自动处理，无需手动操作

## 🔐 安全建议

1. **不要**在仓库中提交 Keystore 文件
2. **不要**在 git 历史中提交 Secrets
3. 定期轮换 Keystore 密码
4. 限制 Secret 访问权限
5. 定期审计 GitHub Actions 日志

## 📚 相关链接

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Android 应用签名指南](https://developer.android.google.cn/studio/publish/app-signing)
- [Gradle 缓存指南](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)

## 💡 进阶配置

### 自定义构建变体
在工作流中修改构建命令：
```yaml
- name: Build specific variant
  run: ./gradlew :TMessagesProj_App:assembleDebug :TMessagesProj_AppStandalone:assembleStandalone
```

### 发送通知
可添加额外的通知步骤，如：
- Slack 通知
- Email 通知
- 钉钉/飞书通知

### 自动化测试
在构建前添加测试步骤：
```yaml
- name: Run tests
  run: ./gradlew test
```

---

**最后更新**: 2024 年  
**维护者**: GitHub Actions 配置
