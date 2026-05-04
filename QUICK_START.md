# 🚀 Quick Start - GitHub Actions APK Build

## ⚡ 5-Minute Setup

### Step 1: Push to GitHub

```bash
git add .github/
git commit -m "Add GitHub Actions APK build workflow"
git push origin master
```

### Step 2: Run Setup Script

**Windows (PowerShell):**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux (Bash):**
```bash
bash setup-github-actions.sh
```

### Step 3: Configure GitHub Secrets

1. Go to GitHub Repository → **Settings**
2. Left Menu → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the following Secrets:

| Name | Value |
|------|-------|
| `KEYSTORE_BASE64` | Copy from script output |
| `KEYSTORE_PASSWORD` | Your keystore password |
| `KEY_ALIAS` | `telegram` |
| `KEY_PASSWORD` | Your key password |

### Step 4: Done!

After pushing code, the workflow will run automatically:
- Go to GitHub Repository → **Actions** tab
- Watch the build progress
- Download APK when complete

---

## 📦 Build Output

### Debug APK
- **Path**: `TMessagesProj_App/build/outputs/apk/debug/`
- **Download**: Actions → Workflow → `debug-apk` Artifact

### Release APK (requires signing)
- **Path**: `TMessagesProj_App/build/outputs/apk/release/`
- **Download**: Actions → Workflow → `release-apk` Artifact

### Standalone APK
- **Path**: `TMessagesProj_AppStandalone/build/outputs/apk/standalone/`
- **Download**: Actions → Workflow → `debug-apk` Artifact

---

## 🔄 Auto-Trigger Events

Workflows run automatically in these cases:

| Event | Workflow | Description |
|-------|----------|-------------|
| Push to `master/main/develop` | build-apk.yml | Auto build Debug + Release |
| Create Pull Request | build-apk.yml | Auto build Debug version |
| Create Release | release-apk.yml | Build and attach to Release |
| Manual trigger | Any workflow | Run from Actions page |

---

## 🛠️ Troubleshooting

### ❌ APK Not Found

**Checklist:**
- [ ] Is `APP_PACKAGE` configured in `gradle.properties`?
- [ ] Are there errors in the build logs?
- [ ] Is NDK/SDK version compatible?

### ❌ Signing Failed

**Checklist:**
- [ ] Are Secrets correctly configured?
- [ ] Is keystore password correct?
- [ ] Does KEY_ALIAS exist in keystore?

### ❌ Build Timeout

**Solutions:**
- Increase GitHub Actions timeout (max 6 hours)
- Enable Gradle caching (already configured)
- Remove unnecessary build variants

### ❌ Permission Error

**Solutions:**
- Ensure `gradlew` has execute permission
- Check GitHub Secrets permissions
- Verify workflow file permissions

---

## 📚 Resources

- 📖 [Full Configuration Guide](.github/GITHUB_ACTIONS_README.md)
- 📖 [GitHub Actions Documentation](https://docs.github.com/en/actions)
- 📖 [Android App Signing](https://developer.android.google.cn/studio/publish/app-signing)

---

## 💡 Advanced Usage

### Create Release with Auto-Attached APK

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

GitHub will automatically:
1. Create Release
2. Build APK
3. Attach APK to Release

### Manual Workflow Trigger

1. Go to GitHub Repository → **Actions**
2. Select workflow (e.g., "Build and Upload APK")
3. Click **Run workflow**
4. Select branch and options
5. Click **Run workflow**

### View Build Logs

```
GitHub Web Interface:
1. Actions → [Workflow Name] → [Latest Run] → [Build Job]
2. Scroll down to see detailed logs
3. Search for keywords like "error", "warning"
```

---

## ✨ Best Practices

1. **Test Regularly** - Push code at least weekly
2. **Monitor Logs** - Fix issues early
3. **Backup Keys** - Keep keystore file safe
4. **Use Tags** - Track releases with git tags
5. **Update Docs** - Keep Secrets and config in sync

---

**🎉 You're ready to automate your builds!**

Questions? Check the [Full Configuration Guide](.github/GITHUB_ACTIONS_README.md) or build logs.
