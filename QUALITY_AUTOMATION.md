# Quality Automation Setup

This repository uses automated code quality tools to maintain consistent standards across all code changes.

## 🚀 Quick Start

### For New Contributors

1. **Install dependencies** (if not already done):
   ```bash
   # For JavaScript/Node.js projects
   npm install
   
   # For Python projects
   pip install -r requirements.txt
   # or
   pip install -e .
   
   # For PHP projects
   composer install
   ```

2. **Install pre-commit hooks**:
   ```bash
   pip install pre-commit
   pre-commit install
   ```

3. **Run quality checks**:
   ```bash
   ./scripts/quality-check.sh
   ```

### Daily Development Workflow

1. **Before committing**, run auto-fix:
   ```bash
   ./scripts/auto-fix.sh
   ```

2. **Check your changes**:
   ```bash
   git diff
   ```

3. **Run quality validation**:
   ```bash
   ./scripts/quality-check.sh
   ```

4. **Commit and push**:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push
   ```

## 🔧 Manual Commands

### JavaScript/TypeScript/React

```bash
# Check for issues
npm run lint

# Auto-fix safe issues
npm run auto-fix:apply

# Preview what would be fixed
npm run auto-fix:preview

# Type checking
npm run type-check

# Run tests with coverage
npm run test:coverage
```

### Python

```bash
# Format code with Black
black .

# Sort imports
isort .

# Check code style
flake8 .

# Run tests with coverage
pytest --cov=src
```

### PHP

```bash
# Fix code style
php-cs-fixer fix

# Preview fixes
php-cs-fixer fix --dry-run --diff

# Run static analysis
phpstan analyse

# Run tests
phpunit
```

## 🎯 Testing Requirements

Our automated system classifies changes into three tiers:

### 🔴 Tier 1: Critical (Must-Have Tests)
- **Triggers**: Changes to `auth/`, `payment/`, `security/`, `admin/` paths
- **Requirements**: Comprehensive testing including:
  - Unit tests for all modified functions
  - Integration tests for API endpoints
  - Security validation tests
  - Edge case coverage
- **Examples**: Login systems, payment processing, user permissions

### 🟡 Tier 2: Important (Contextual Tests)
- **Triggers**: Changes to `api/`, `components/`, `services/`, `models/` paths
- **Requirements**: Standard testing including:
  - Unit tests for modified components
  - Integration tests for new features
  - Error handling tests
- **Examples**: New React components, API endpoints, business logic

### 🟢 Tier 3: Optional
- **Triggers**: Documentation, configuration, README changes
- **Requirements**: Testing optional but recommended
- **Examples**: README updates, config changes, documentation

### Bypass Testing Requirements

Add `@testException` to your PR description to skip testing requirements:

```markdown
## Changes
Updated documentation for API endpoints

@testException - Documentation only changes
```

## 🤖 Auto-Fix Behavior

### ✅ Always Safe (Auto-Fix Enabled)
- Trailing whitespace removal
- Normalize LF endings
- Consistent indentation
- Alphabetical import sorting
- Language-specific quotes (safe, neutral)

### ❌ Never Auto-Fix (Blocked)
- Logic changes (e.g., variable declarations)
- Function parameter edits
- Conditionals or type casting

### Language-Specific Examples

**JavaScript/React:**
- ✅ Auto-fixed: `'quotes'` → `"quotes"`, trailing spaces
- ❌ Blocked: `const` → `let`, function params

**Python:**
- ✅ Auto-fixed: line length, import order
- ❌ Blocked: function signatures, logic changes

**PHP:**
- ✅ Auto-fixed: PSR12 formatting, spacing
- ❌ Blocked: variable types, method changes

## 🚨 Troubleshooting

### Common Issues & Solutions

#### ❌ "Auto-fix validation failed"
✅ **Solutions:**
- Run: `npm run auto-fix:preview`
- Check: Are you editing templated strings?
- Fix: Use `@testException` if intentional

#### ❌ "Tests required but missing"
✅ **Solutions:**
- Check: Which tier does your change fall into?
- Run: `npm run test:requirements -- --explain`
- Add: Basic tests for new components/APIs

#### ❌ "Pipeline taking too long"
✅ **Solutions:**
- Check: Are workflows running in parallel?
- Contact: #devops-support for optimization

### Disable Auto-Fix Temporarily

```bash
# Disable for sensitive changes
git config AUTO_FIX_DISABLED true

# Re-enable automation
git config AUTO_FIX_DISABLED false
```

## 📊 Success Indicators

### ✅ Know It's Working When:
- Green checkmarks in PR status checks
- Auto-fix bot commits with 🤖 emoji
- Fewer style comments in code reviews
- Coverage reports show green percentages
- SonarCloud quality gate passes

### 🚩 Red Flags to Watch For:
- Repeated auto-fix rollbacks
- Tests failing after auto-fix
- Manual style fixes needed
- Long pipeline execution times

## 💡 IDE Integration

### VS Code
1. **Install Extensions**:
   - ESLint
   - Prettier
   - GitLens
   - Python (if using Python)
   - PHP CS Fixer (if using PHP)

2. **Enable Settings**:
   - Format on save
   - Auto-fix on save

### PhpStorm/WebStorm
1. **Enable**:
   - ESLint integration
   - Prettier integration
   - Auto-format on save

2. **Configure**:
   - Save actions for formatting
   - Code quality inspection profiles

## 🔐 Security & Exclusions

- 🔒 All `auth/` & `payment/` paths require manual review
- 🛑 `.env`, `migrations/`, and config folders excluded from auto-fix
- 🔍 Automatic security scanning with Trivy and TruffleHog

## 🤝 Team Collaboration

### Getting Help
- 🔗 Share this playbook link in PR comments
- 💬 Use #code-quality Slack for questions
- 👥 Pair program through first setup

### Code Review Focus
- 🎨 Style issues → Auto-fixed, don't comment
- 🧠 Logic issues → Still need human review
- 📊 Test coverage → Check automated reports first

## 📚 Additional Resources

- [Setup Script](./setup-quality-automation.sh) - One-command setup
- [Quality Check Script](./scripts/quality-check.sh) - Local validation
- [Auto-Fix Script](./scripts/auto-fix.sh) - Safe formatting fixes
- [GitHub Workflows](./.github/workflows/) - CI/CD automation

---

## 🎉 Final Notes

**Keep it simple. Keep it visual. Keep it actionable!**

This automation system is designed to eliminate friction in your development workflow while maintaining high code quality standards. When in doubt, run the scripts and let the automation guide you.

**Questions?** Check our [troubleshooting section](#-troubleshooting) or reach out to the team in #code-quality Slack!