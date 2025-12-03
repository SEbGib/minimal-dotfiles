# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in this dotfiles repository, please report it responsibly:

### How to Report

**DO NOT** open a public GitHub issue for security vulnerabilities.

Instead:
1. Open a [Security Advisory](https://github.com/SEbGib/minimal-dotfiles/security/advisories/new)
2. Or open a private issue on GitHub

### What to Include

Please include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Response Timeline

- **Acknowledgment:** Within 48 hours
- **Initial Assessment:** Within 7 days
- **Fix Timeline:** Depends on severity (Critical: 7 days, High: 14 days, Medium: 30 days)

---

## Security Best Practices for Users

### Before Using These Dotfiles

⚠️ **IMPORTANT:** This repository contains configuration templates, not ready-to-use configs.

**Required Actions:**

1. **Review all templates** before applying to your system
2. **Configure personal information** (see README.md)
3. **Generate your own SSH keys** (never use someone else's)
4. **Set your own API tokens** via environment variables
5. **Test in a VM first** before applying to your main system

### Sensitive Information

This repository is designed to be **public-safe**:

✅ **Safe:**
- Configuration templates with placeholders
- Installation scripts
- Documentation
- Plugins and tools

❌ **Never Committed:**
- Actual SSH keys
- API tokens
- Passwords
- Personal emails (replaced with placeholders)
- Private hostnames (replaced with examples)

### File Permissions

Chezmoi automatically sets secure permissions:

- `private_*` files → `600` (owner read/write only)
- `executable_*` files → `755` (owner rwx, others rx)
- Regular dotfiles → `644` (owner rw, others r)

### Environment Variables

Store secrets in environment variables, NOT in files:

```bash
# In ~/.zshrc or ~/.bashrc
export GITHUB_TOKEN="your_token_here"
export OPENAI_API_KEY="your_key_here"
export NOTION_API_TOKEN="your_token_here"

# Make sure this file has restricted permissions
chmod 600 ~/.zshrc
```

### SSH Key Management

**Best Practices:**

1. **Generate strong keys:**
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. **Use passphrases** on private keys

3. **Restrict permissions:**
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_ed25519
   chmod 644 ~/.ssh/id_ed25519.pub
   ```

4. **Use SSH agent:**
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

### API Token Security

**DO:**
- ✅ Use environment variables
- ✅ Rotate tokens regularly
- ✅ Use token scopes (minimal permissions)
- ✅ Revoke unused tokens

**DON'T:**
- ❌ Commit tokens to git
- ❌ Share tokens between projects
- ❌ Use personal tokens in CI/CD
- ❌ Store tokens in plain text files

---

## Known Security Considerations

### MCP Servers

This configuration includes MCP (Model Context Protocol) servers:

- **Context7:** Documentation search (no auth required)
- **Notion:** Workspace access (requires token)
- **Browser:** Web automation (requires Chrome)

**Security Measures:**
- MCP servers run locally only
- Network access restricted (see `private_dot_env.tmpl`)
- Audit logging enabled
- Command blocking for dangerous operations

### Third-Party Tools

This repository installs 70+ third-party tools.

**Your Responsibility:**
- Keep tools updated: `brew upgrade`, `apt update && apt upgrade`
- Review what gets installed: `INSTALLED_TOOLS.md`
- Understand security implications of each tool

### Chezmoi Security

Chezmoi is the core dotfiles manager:

- Templates are processed locally
- No data sent to external servers
- Source directory should be private (git-controlled)
- Target directory is your home (`~/`)

**Important:** Review templates before `chezmoi apply`

---

## Security Features Included

### 1. Dotfiles Security Plugin

- Blocks reading sensitive files (`.env`, `.ssh/id_*`, etc.)
- Prevents accidental exposure in AI chats
- Configurable block list

### 2. MCP Security

- Network domain allowlist
- Command blocklist (`rm -rf`, `sudo`, etc.)
- Execution time limits
- Audit logging

### 3. Secure Defaults

- No telemetry (`DO_NOT_TRACK=1`)
- Restrictive file permissions
- Strong SSH ciphers
- GPG/age for encryption

---

## Version History

| Date | Version | Changes |
|------|---------|---------|
| 2025-11-30 | 1.0 | Initial public release with security audit |

---

## Acknowledgments

Security best practices inspired by:
- [OWASP Cheat Sheets](https://cheatsheetseries.owasp.org/)
- [Chezmoi Security](https://www.chezmoi.io/user-guide/frequently-asked-questions/security/)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)

---

**Last Updated:** November 30, 2025  
**Maintained By:** Repository Contributors

For questions or concerns, please open an issue (non-security) or follow the reporting process above (security issues).
