---
name: Build Failure Report
about: Report a GitHub Actions APK build failure
title: "[Build Failure] "
labels: build, bug
assignees: ''

---

## 🐛 Build Failure Report

### Build Information
- **Workflow**: [build-apk.yml / release-apk.yml]
- **Branch**: [master / main / develop]
- **Run URL**: [Link to the failing workflow run]
- **Date**: [YYYY-MM-DD]

### Error Details

#### Error Message
```
[Paste the error message here]
```

#### Build Log Excerpt
```
[Paste relevant log lines here]
```

### Steps to Reproduce

1. [First step]
2. [Second step]
3. [etc.]

### Environment
- **OS**: [Windows / macOS / Linux]
- **Java Version**: 17
- **Gradle Version**: [version from build output]
- **Android SDK**: [API level]
- **NDK Version**: [version]

### Checklist

- [ ] I have checked the Workflow logs
- [ ] I have verified all Secrets are configured correctly
- [ ] I have checked the troubleshooting guide in `.github/GITHUB_ACTIONS_README.md`
- [ ] I have tried running the build locally and it works
- [ ] I have reviewed recent code changes that might cause the issue

### Additional Context

[Any other context about the problem]

### Possible Solution

[If you have any ideas on how to fix this]
