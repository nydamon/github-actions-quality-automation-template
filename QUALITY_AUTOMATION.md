# Quality Automation & AI PR Agent Setup

This repository uses automated code quality tools and AI-powered PR analysis to maintain consistent standards across all code changes.

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

### 🤖 AI PR Agent Setup (One-Time Setup)

To enable automatic PR descriptions and AI code review, repository administrators need to:

1. **Get OpenAI API Key**:
   - Visit: https://platform.openai.com/api-keys
   - Create a new API key
   - Copy the key (starts with `sk-`)

2. **Add Repository Secret**:
   - Go to repository `Settings` → `Secrets and variables` → `Actions`
   - Click `New repository secret`
   - Name: `OPENAI_API_KEY`
   - Value: Your OpenAI API key
   - Click `Add secret`

3. **Verify Setup**:
   - Create a test PR
   - AI should automatically generate a description within 1-2 minutes
   - Look for comments from the PR Agent bot

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

4. **Create PR and let AI help**:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push
   # Create PR - AI will automatically generate description
   ```

## 🤖 AI PR Agent Features

### Automatic PR Descriptions

When you create a new PR, the AI automatically generates:

- **📝 Summary**: Clear overview of what changed
- **🚶 Walkthrough**: Step-by-step explanation of changes
- **🏷️ Type Classification**: Feature, bug fix, docs, etc.
- **🔖 Labels**: Automatically applied based on content
- **🔒 Security Notes**: Highlights for auth/payment changes

**Example AI-Generated Description:**
```markdown
## Summary
This PR implements user authentication middleware with JWT token validation and adds comprehensive error handling for login endpoints.

## Walkthrough
- Added `authMiddleware.js` with token validation logic
- Updated `/login` endpoint to return proper error codes
- Added unit tests for authentication flows
- Updated documentation for new auth requirements

## Type
🔒 security

## Security Considerations
- JWT secret is properly secured in environment variables
- Added rate limiting to prevent brute force attacks
- Implemented proper error handling to avoid information leakage
```

### Interactive AI Commands

Use these commands in PR comments to get AI assistance:

#### `/describe` - Generate/Update PR Description
```bash
# In any PR comment, type:
/describe

# AI will regenerate the PR description with latest changes
```

#### `/review` - Comprehensive Code Review
```bash
# In any PR comment, type:
/review

# AI provides detailed code review with:
# - Security analysis
# - Performance suggestions
# - Best practice recommendations
# - Bug detection
```

#### `/improve` - Code Improvement Suggestions
```bash
# In any PR comment, type:
/improve

# AI suggests specific code improvements for:
# - Performance optimization
# - Readability enhancements
# - Error handling
# - Security hardening
```

#### `/ask` - Ask Questions About Code
```bash
# In any PR comment, type:
/ask How does the new caching mechanism work?
/ask Why did you choose this approach over alternatives?
/ask What are the security implications of this change?

# AI analyzes your code and provides detailed answers
```

#### `/test` - Test Generation Assistance
```bash
# In any PR comment, type:
/test

# AI suggests what tests should be added based on:
# - Code changes made
# - Risk assessment
# - Coverage gaps
```

#### `/help` - Show Available Commands
```bash
# In any PR comment, type:
/help

# Shows all available AI commands and usage
```

### AI Command Examples

**Real Usage Examples:**

```bash
# Get AI code review
/review

# Ask about specific functionality
/ask Can you explain how the payment validation works in this PR?

# Get improvement suggestions
/improve

# Regenerate description after major changes
/describe
```

### 🎯 AI Configuration Highlights

Our AI is configured to focus on:

- **🔒 Security**: Extra attention to auth/, payment/, security/ paths
- **💼 Business Impact**: Emphasizes user-facing changes
- **⚡ Performance**: Identifies optimization opportunities
- **📚 Readability**: Suggests cleaner, more maintainable code
- **🧪 Testing**: Recommends appropriate test coverage

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

#### 🤖 "AI not generating descriptions"
✅ **Solutions:**
- Check: Is `OPENAI_API_KEY` secret set correctly?
- Verify: Repository has proper permissions for PR Agent
- Wait: AI can take 1-2 minutes to process
- Try: Use `/describe` command manually

#### 🤖 "AI commands not working"
✅ **Solutions:**
- Check: Command format (starts with `/`)
- Verify: You're commenting on a PR, not an issue
- Wait: Commands can take 30-60 seconds to process
- Try: `/help` to see available commands

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
- **🤖 AI-generated PR descriptions appear automatically**
- **💬 AI responds to commands in PR comments**

### 🚩 Red Flags to Watch For:
- Repeated auto-fix rollbacks
- Tests failing after auto-fix
- Manual style fixes needed
- Long pipeline execution times
- **🤖 AI not generating descriptions for new PRs**
- **❌ AI commands timing out or not responding**

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
- 🤖 AI analyzes security implications of code changes

## 🤝 Team Collaboration

### Getting Help
- 🔗 Share this playbook link in PR comments
- 💬 Use #code-quality Slack for questions
- 👥 Pair program through first setup
- **🤖 Use `/ask` in PRs for AI assistance**

### Code Review Focus
- 🎨 Style issues → Auto-fixed, don't comment
- 🧠 Logic issues → Still need human review
- 📊 Test coverage → Check automated reports first
- **🤖 AI suggestions → Review and discuss as needed**

## 📚 Additional Resources

- [Setup Script](./setup-quality-automation.sh) - One-command setup
- [Quality Check Script](./scripts/quality-check.sh) - Local validation
- [Auto-Fix Script](./scripts/auto-fix.sh) - Safe formatting fixes
- [GitHub Workflows](./.github/workflows/) - CI/CD automation
- [AI Configuration](./.pr_agent.toml) - PR Agent customization

## 🚀 Advanced AI Usage Tips

### Maximize AI Value
1. **Write descriptive commit messages** - AI uses these for better descriptions
2. **Ask specific questions** - `/ask Why did you choose Redis over Memcached?`
3. **Request focused reviews** - `/review --focus=security` for security-specific analysis
4. **Use iteratively** - Run `/improve` multiple times as you make changes

### Best Practices for AI Commands
- **Be specific**: Instead of `/ask about this code`, try `/ask How does the JWT validation middleware handle expired tokens?`
- **Use context**: AI understands your PR changes, so reference them directly
- **Combine commands**: Use `/review` first, then `/improve` for specific suggestions
- **Follow up**: Ask clarifying questions based on AI responses

### AI Prompt Customization
The AI behavior is configured in `.pr_agent.toml`:
- Business impact focus for TheCreditPros
- Security emphasis for sensitive paths
- Performance optimization suggestions
- Custom labels for your workflow

---

## 🎉 Final Notes

**Keep it simple. Keep it visual. Keep it actionable. Keep it intelligent!**

This automation system is designed to eliminate friction in your development workflow while maintaining high code quality standards. The AI assistant acts as your coding companion, helping with descriptions, reviews, and improvements.

**New to AI-assisted development?** Start with:
1. Create a PR and watch the auto-description
2. Try `/review` on your next PR
3. Ask questions with `/ask`
4. Gradually incorporate AI suggestions

**Questions?** Check our [troubleshooting section](#-troubleshooting), use `/help` in any PR, or reach out to the team in #code-quality Slack!
