# 📱 Telegram Automated APK Build System

A complete **GitHub Actions CI/CD system** configured for the Telegram project to automatically build, sign, and publish APK applications.

## 🎯 Features

✅ **Automatic Build** - Triggered automatically on code push  
✅ **Multi-Platform** - Supports Debug, Release, and Standalone variants  
✅ **Auto Signing** - APK signing using Keystore  
✅ **Auto Upload** - Upload to GitHub Artifacts and Releases  
✅ **Release Support** - Auto-attach APK when creating Release  
✅ **Firebase Integration** - Optional Firebase App Distribution support  
✅ **Full Documentation** - Complete guides in English and Chinese  

## 📁 Project Structure

```
Project Root/
├── .github/
│   ├── workflows/
│   │   ├── build-apk.yml              # Main build workflow (on push)
│   │   └── release-apk.yml            # Release workflow (on Release)
│   ├── ISSUE_TEMPLATE/
│   │   ├── build-failure.md           # Build failure report template
│   │   └── build-improvement.md       # Improvement suggestion template
│   └── GITHUB_ACTIONS_README.md       # Detailed configuration guide
│
├── setup-github-actions.sh            # Linux/macOS setup script
├── setup-github-actions.ps1           # Windows PowerShell setup script
├── QUICK_START.md                     # Quick start guide (English)
├── QUICK_START_CN.md                  # Quick start guide (Chinese)
├── GITHUB_ACTIONS_SETUP_SUMMARY.md    # Setup summary
├── SETUP_CHECKLIST.md                 # Setup checklist
│
└── [Other project files...]
    ├── TMessagesProj/                 # Library module
    ├── TMessagesProj_App/             # Main app module
    ├── TMessagesProj_AppStandalone/   # Standalone app module
    ├── gradle.properties              # Gradle configuration (ready)
    ├── settings.gradle                # Gradle settings
    └── build.gradle                   # Root Gradle configuration
```

## 🚀 Quick Start

### 1️⃣ Run Setup Script (5 minutes)

Choose the script for your operating system:

**Windows (PowerShell):**
```powershell
.\setup-github-actions.ps1
```

**macOS/Linux (Bash):**
```bash
bash setup-github-actions.sh
```

The script will automatically:
- ✅ Check for Keystore file
- ✅ Generate Base64 encoding
- ✅ Copy to clipboard (if available)
- ✅ Save to file (if not available)

### 2️⃣ Configure GitHub Secrets

Visit: **GitHub Repository → Settings → Secrets and variables → Actions**

Add the following 4 Secrets:

| Name | Value |
|------|-------|
| `KEYSTORE_BASE64` | Copy from script output |
| `KEYSTORE_PASSWORD` | Your keystore password |
| `KEY_ALIAS` | `telegram` |
| `KEY_PASSWORD` | Your key password |

### 3️⃣ Push Code

```bash
git add .github/
git add *.md
git add setup-github-actions.*
git commit -m "Add GitHub Actions APK build automation"
git push origin master
```

### ✅ Done!

The workflow will run automatically. Go to **Actions** tab to monitor progress.

---

## 📦 Build Output

### APK File Locations

| Type | Location | Access |
|------|----------|--------|
| **Debug APK** | `TMessagesProj_App/build/outputs/apk/debug/` | Actions → Artifacts |
| **Release APK** | `TMessagesProj_App/build/outputs/apk/release/` | Actions → Artifacts |
| **Standalone APK** | `TMessagesProj_AppStandalone/build/outputs/apk/standalone/` | Actions → Artifacts |

### Download Methods

#### Method 1: GitHub Actions Artifacts (Temporary)
1. Go to GitHub Repository → **Actions**
2. Click the latest workflow run
3. Download Artifacts folder
4. Retention: 30-90 days

#### Method 2: GitHub Releases (Permanent)
1. Create a Git Release: `git tag v1.0.0 && git push origin v1.0.0`
2. GitHub Actions will auto-build and attach APK
3. Go to **Releases** page to download
4. Permanently saved

---

## 🔄 Workflow Triggers

### Auto-Trigger Events

| Event | Workflow | Description |
|-------|----------|-------------|
| **Push to master/main/develop** | `build-apk.yml` | Auto build Debug + Release |
| **Create Pull Request** | `build-apk.yml` | Auto build Debug version |
| **Publish Release** | `release-apk.yml` | Build and attach to Release |
| **Manual Trigger** | Any workflow | Via Actions page → Run workflow |

### Manual Workflow Trigger

1. Go to GitHub Repository → **Actions**
2. Select workflow (e.g., "Build and Upload APK")
3. Click **Run workflow**
4. Select branch
5. Click **Run workflow**

---

## 🔐 Security & Privacy

### ✅ Security Best Practices

- ✅ Use GitHub Secrets for sensitive information
- ✅ Keystore never committed to Git
- ✅ Secrets automatically encrypted
- ✅ Decrypted only when needed

### ⚠️ Security Warnings

- ❌ Don't hardcode passwords in code
- ❌ Don't upload Keystore to Git
- ❌ Don't print secrets in logs
- ❌ Regularly rotate Keystore passwords

### .gitignore Configuration

Ensure `.gitignore` contains:
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

## 📚 Documentation Navigation

### Quick Reference

| File | Purpose | Time |
|------|---------|------|
| **QUICK_START.md** | English quick start | 5 min |
| **QUICK_START_CN.md** | Chinese quick start | 5 min |
| **GITHUB_ACTIONS_SETUP_SUMMARY.md** | Setup summary | 10 min |
| **.github/GITHUB_ACTIONS_README.md** | Full guide | 20 min |
| **SETUP_CHECKLIST.md** | Verification checklist | As needed |

### Choose Document by Scenario

**I want to get started quickly**
→ Read `QUICK_START.md` or `QUICK_START_CN.md`

**I want detailed configuration information**
→ Read `.github/GITHUB_ACTIONS_README.md`

**I want to verify the setup is complete**
→ Use `SETUP_CHECKLIST.md`

**I encountered a build failure**
→ Check troubleshooting section in `.github/GITHUB_ACTIONS_README.md`

**I want to contribute improvements**
→ Submit an issue using `.github/ISSUE_TEMPLATE/build-improvement.md`

---

## 🛠️ System Requirements

### Hardware
- CPU: Modern multi-core processor
- RAM: At least 8GB (GitHub Actions provides 7GB)
- Disk: At least 10GB free space

### Software
- Git
- Java 17
- Android SDK (automatically configured by GitHub Actions)
- NDK 21.4.7075529 (project configured)

### GitHub
- Valid GitHub account
- Admin permissions on repository
- Valid Keystore file (optional)

---

## 🎓 Learning Resources

### GitHub Actions
- [GitHub Actions Official Docs](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Security Best Practices](https://docs.github.com/en/actions/security-guides)

### Android Development
- [Android App Signing](https://developer.android.google.cn/studio/publish/app-signing)
- [Gradle Build System](https://developer.android.google.cn/studio/build)
- [APK Packaging Guide](https://developer.android.google.cn/studio/build/building-cmdline)

### Telegram Project
- [Telegram Official GitHub](https://github.com/DrKLO/Telegram)
- [Telegram Developer Docs](https://core.telegram.org/)

---

## 💡 Advanced Usage

### Build Specific Variants

Edit `.github/workflows/build-apk.yml` and modify the build command:

```yaml
- name: Build specific variants
  run: ./gradlew :TMessagesProj_App:assembleDebug :TMessagesProj_AppStandalone:assembleStandalone
```

### Add Notifications

You can add notification steps for Slack, Email, or other services. Example Slack notification:

```yaml
- name: Send Slack notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
  if: always()
```

### Automated Testing

Add test steps before building:

```yaml
- name: Run tests
  run: ./gradlew test
```

### Multi-Architecture Build

Build APK for multiple architectures:

```yaml
- name: Build universal APK
  run: ./gradlew bundleRelease
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: APK not found
**Solution**: Check "Find APK files" step in logs, verify build.gradle configuration

**Issue**: Signing failed
**Solution**: Verify Secrets configuration, check Keystore password

**Issue**: Build timeout
**Solution**: Enable Gradle caching, remove unnecessary variants

**Issue**: Permission error
**Solution**: Handled automatically, no manual action needed

See `.github/GITHUB_ACTIONS_README.md` for complete troubleshooting guide.

---

## 📊 Project Statistics

| Metric | Value |
|--------|-------|
| **Workflows** | 2 |
| **Steps** | 15+ |
| **Config Files** | 8+ |
| **Documentation** | 6+ |
| **Scripts** | 2 |
| **Platform Support** | Windows, macOS, Linux |

---

## 🤝 Contributing

Improvements to this CI/CD system are welcome!

### Submit Improvements

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -m "Add improvement"`)
4. Push branch (`git push origin feature/improvement`)
5. Create a Pull Request

### Report Issues

Use `.github/ISSUE_TEMPLATE/build-failure.md` template to report issues.

---

## 📝 License

This configuration is provided as-is. The Telegram project maintains its own license.

---

## 🎉 Get Started

**You're ready for automated APK builds now!**

1. ✅ Run setup script
2. ✅ Configure GitHub Secrets
3. ✅ Push code
4. ✅ Wait for build to complete
5. ✅ Download APK

**Happy building!** 🚀

---

**Last Updated**: 2024  
**Configuration Status**: ✅ Ready  
**Maintained By**: GitHub Actions System
