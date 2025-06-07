# GitHub Actions Quality Automation Template

> **Comprehensive quality automation for JavaScript/React, Python, and PHP projects**

Intelligent auto-fix, risk-based testing enforcement, unified quality pipelines, and **AI-powered PR descriptions** that eliminate manual code review bottlenecks while maintaining high standards.

## 🚀 Quick Start

### One-Command Setup

```bash
bash setup-quality-automation.sh
```

**This will:**
- 🔍 Detect JavaScript, Python, PHP, and React languages
- 🧩 Copy `.eslintrc.*`, `.prettierrc`, and other required configs
- 🔄 Install pre-commit hooks
- 🤖 Set up GitHub Actions workflows
- 🧠 Configure AI-powered PR analysis

### 🤖 AI Setup (Required for PR Agent)

To enable automatic PR descriptions and AI code review:

1. **Get OpenAI API Key**: Visit [OpenAI API](https://platform.openai.com/api-keys)
2. **Add to Repository Secrets**: 
   - Go to: `Settings` → `Secrets and variables` → `Actions`
   - Add secret: `OPENAI_API_KEY` with your API key
3. **That's it!** PR Agent will automatically generate descriptions for new PRs

### IDE Integration (Optional but Recommended)

**VS Code:**
- 📅 Install: ESLint, Prettier, GitLens
- ⚙️ Enable: Format on save, auto-fix on save

**PhpStorm/WebStorm:**
- ✅ Enable: ESLint, Prettier, auto-format
- 🛠 Configure: Save actions for formatting

## 📦 What's Included

### Core Infrastructure
- **Setup Script** (`setup-quality-automation.sh`) - Intelligent language detection and configuration
- **GitHub Workflows** - Main quality pipeline, auto-fix, test enforcement, and **AI PR analysis**
- **Pre-commit Hooks** - Local validation before code reaches remote
- **Development Scripts** - Quality check and auto-fix utilities
- **IDE Configurations** - VS Code and JetBrains setup
- **🧠 AI PR Agent** - Automatic PR descriptions, code review, and suggestions

### 🤖 AI-Powered Features

#### Automatic PR Descriptions
- **Triggers**: Every new PR automatically gets a comprehensive description
- **Content**: Summary, walkthrough, type classification, and labels
- **Smart**: Preserves original user content while enhancing with AI insights

#### Interactive Code Review
- **AI Review**: Intelligent code analysis with security and best practice suggestions
- **Code Improvements**: Automated suggestions for performance and readability
- **Chat Interface**: Ask questions about your code with `/ask <question>`

#### PR Commands
Use these commands in PR comments to trigger AI analysis:

```bash
/describe    # Generate/regenerate PR description
/review      # Comprehensive AI code review  
/improve     # Code improvement suggestions
/ask         # Ask questions about the code
/test        # Test generation assistance
/help        # Show available commands
```

### Language Support

#### 🟨 JavaScript/TypeScript/React
- **Tools**: ESLint, Prettier, TypeScript
- **Auto-fixes**: Quote consistency, import sorting, formatting
- **Never touches**: Variable declarations, function parameters, JSX logic

#### 🐍 Python
- **Tools**: Black, isort, flake8, pytest
- **Auto-fixes**: Line length, import organization, PEP8 formatting
- **Never touches**: Function signatures, type hints, algorithm logic

#### 🐘 PHP
- **Tools**: PHP CS Fixer, PHPStan, PHPUnit
- **Auto-fixes**: PSR12 compliance, spacing, array formatting
- **Never touches**: Variable types, method signatures, business logic

## 🎯 Three-Tier Testing System

### 🔴 Tier 1: Critical (Must-Have Tests)
**Paths**: `auth/`, `payment/`, `security/`, `admin/`

**Requirements**: Comprehensive testing including unit, integration, and security tests

### 🟡 Tier 2: Important (Contextual Tests)
**Paths**: `api/`, `components/`, `services/`, `models/`

**Requirements**: Standard testing with unit and integration tests

### 🟢 Tier 3: Optional
**Paths**: Documentation, configuration, README changes

**Requirements**: Testing optional but recommended

## 📝 Quick Reference Commands

```bash
# Preview auto-fixes without applying
npm run auto-fix:preview        # JavaScript/TypeScript
./scripts/auto-fix.sh           # All languages

# Apply safe formatting fixes
npm run auto-fix:apply          # JavaScript/TypeScript
black . && isort .              # Python
php-cs-fixer fix                # PHP

# Run comprehensive quality checks
npm run quality:check           # JavaScript/TypeScript
./scripts/quality-check.sh      # All languages

# Test coverage
npm run test:coverage           # JavaScript/TypeScript
pytest --cov=src               # Python
phpunit --coverage-html coverage # PHP

# AI PR Commands (use in PR comments)
/describe                       # Generate PR description
/review                         # AI code review
/improve                        # Code suggestions
/ask "How does this work?"      # Ask AI about code
```

## 🚫 Disable Auto-Fix (When Needed)

```bash
# Temporarily disable
git config AUTO_FIX_DISABLED true

# Re-enable
git config AUTO_FIX_DISABLED false

# In PR description, add:
# @testException - Docs only changes
# @autoFixDisabled - Manual formatting required
```

## 🔧 Architecture Overview

### 1. Intelligent Auto-Fix System
- **What**: Automatically fixes safe formatting issues
- **How**: Pre-commit hooks + GitHub Actions validation
- **Safety**: Triple validation, automatic rollback on failure
- **Scope**: Only cosmetic changes, never business logic

### 2. Risk-Based Testing Enforcement
- **What**: Determines testing requirements based on code changes
- **How**: Analyzes file paths and change patterns
- **Flexibility**: Configurable rules with escape hatches
- **Guidance**: Clear explanations for testing requirements

### 3. Unified Quality Pipeline
- **What**: Single, fast pipeline for all quality checks
- **How**: Parallel execution with smart dependency management
- **Integration**: Works with SonarCloud, coverage tools, security scanners
- **Feedback**: Comprehensive PR comments and status checks

### 4. 🧠 AI-Powered PR Analysis
- **What**: OpenAI-powered code analysis and description generation
- **How**: Analyzes code changes and generates human-readable insights
- **Features**: Auto-descriptions, code review, improvement suggestions
- **Customization**: Configurable via `.pr_agent.toml` for your team's needs

## 📊 Success Metrics

**Target Improvements:**
- 60% reduction in code review time
- 25% faster PR cycle time
- 95% consistency in code formatting
- 40% reduction in style-related technical debt
- **🆕 80% improvement in PR description quality**

**Quality Indicators:**
- ✅ Green checkmarks in PR status checks
- 🤖 Auto-fix bot commits with emoji
- 📉 Fewer style comments in code reviews
- 🟢 Coverage reports show green percentages
- **🧠 AI-generated PR descriptions and reviews**

## 🚨 Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| ❌ Auto-fix validation failed | Run `npm run auto-fix:preview` to see changes |
| ❌ Tests required but missing | Check tier classification, add appropriate tests |
| ❌ Pipeline taking too long | Verify workflows run in parallel, contact DevOps |
| ❌ Manual style fixes needed | Check if auto-fix is disabled, run local scripts |
| **🤖 AI not generating descriptions** | **Check `OPENAI_API_KEY` secret is set correctly** |
| **🤖 AI commands not working** | **Ensure PR Agent workflow has proper permissions** |

### Getting Help
- 📚 [Comprehensive Guide](./QUALITY_AUTOMATION.md)
- 💬 #code-quality Slack channel
- 👥 Pair programming sessions
- 🔗 Share this template in PR comments
- **🤖 Use `/help` command in any PR for AI assistance**

## 🔐 Security & Safety

- **Code Safety**: Only touches formatting, never business logic
- **Access Control**: Minimal GitHub bot permissions
- **Audit Trail**: Complete git history of all changes
- **Security Scanning**: Automatic vulnerability detection
- **Manual Override**: Always available for edge cases
- **🔒 AI Privacy**: OpenAI processes code temporarily, no permanent storage

## 🌍 Contributing

### Using This Template

1. **Fork or download** this repository
2. **Copy files** to your project:
   ```bash
   # Copy core files
   cp setup-quality-automation.sh your-project/
   cp -r .github/workflows your-project/.github/
   cp -r scripts your-project/
   cp QUALITY_AUTOMATION.md your-project/
   cp .pr_agent.toml your-project/  # AI configuration
   ```
3. **Add OpenAI API Key** to repository secrets
4. **Run setup**:
   ```bash
   cd your-project
   bash setup-quality-automation.sh
   ```
5. **Customize** configurations for your specific needs

### Customization

- **Modify** `.eslintrc.js`, `.prettierrc`, `pyproject.toml`, `.php-cs-fixer.php`
- **Adjust** tier classification in `.github/workflows/test-enforcement.yml`
- **Update** excluded paths in workflow files
- **Add** language-specific tools as needed
- **🤖 Customize AI behavior** in `.pr_agent.toml`

## 🗺️ Implementation Roadmap

### Week 1-2: Foundation
- 🛠 Infrastructure setup
- 👥 Team preparation
- 🔍 Pilot project selection
- **🤖 AI PR Agent setup and testing**

### Week 3-4: Pilot
- 🧪 Limited deployment (3-5 repositories)
- 📊 Performance monitoring
- 🗺️ Feedback collection and iteration
- **📝 AI description quality assessment**

### Week 5-6: Rollout
- 🚀 Team-by-team expansion
- 🎆 All remaining repositories
- 💹 Metrics monitoring
- **🎯 AI prompt optimization**

### Week 7-8: Maturation
- 🤖 Advanced features
- 📊 Custom analytics
- 🔗 Additional tool integrations
- **🧠 Advanced AI features and fine-tuning**

## 📜 Documentation

- **[Quality Automation Guide](./QUALITY_AUTOMATION.md)** - Comprehensive developer guide
- **[Setup Script](./setup-quality-automation.sh)** - Automated configuration
- **[Workflow Files](./.github/workflows/)** - GitHub Actions implementation
- **[Development Scripts](./scripts/)** - Local development utilities
- **[AI Configuration](./.pr_agent.toml)** - PR Agent customization

## 🎆 ROI Calculator

**Example for team of 10 developers:**

```
Current: 5 hours/week/developer on style issues = 50 hours/week
After automation: 2 hours/week/developer = 20 hours/week
AI PR descriptions save: 0.5 hours/week/developer = 5 hours/week
Total savings: 35 hours/week × $100/hour = $3,500/week = $182,000/year
Implementation cost: ~$20,000 (3 weeks × developer cost)
OpenAI API cost: ~$100/month = $1,200/year
ROI: 800%+ annual return
```

## 🔗 Links & Resources

- **GitHub Repository**: [Quality Automation Template](https://github.com/nydamon/github-actions-quality-automation-template)
- **Issues & Feedback**: [GitHub Issues](https://github.com/nydamon/github-actions-quality-automation-template/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nydamon/github-actions-quality-automation-template/discussions)
- **PR Agent Documentation**: [Codium-ai/pr-agent](https://github.com/Codium-ai/pr-agent)

---

## 🎉 Key Benefits

✅ **Eliminate** style discussions in code reviews  
✅ **Reduce** review time by 60%  
✅ **Ensure** consistent quality across all repositories  
✅ **Accelerate** feature delivery  
✅ **Scale** quality standards as teams grow  
✅ **Focus** developers on business logic, not formatting  
✅ **🧠 Generate** professional PR descriptions automatically  
✅ **🔍 Get** AI-powered code review insights  

**Ready to transform your development workflow with AI?**

```bash
# 1. Add OpenAI API key to repository secrets
# 2. Run setup
bash setup-quality-automation.sh
# 3. Create a PR and watch the magic happen! 🎭
```

*Keep it simple. Keep it visual. Keep it actionable. Keep it intelligent!*
