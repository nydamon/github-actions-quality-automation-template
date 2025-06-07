#!/bin/bash

# GitHub Actions Quality Automation Setup Script
# Detects project languages and sets up comprehensive quality automation

set -e

echo "🚀 Setting up GitHub Actions Quality Automation..."
echo "===================================================="

# Function to detect project languages
detect_languages() {
    local detected_languages=()
    
    if [[ -f "package.json" ]] || find . -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" -o -name "*.vue" -maxdepth 3 | grep -q .; then
        detected_languages+=("javascript")
        echo "✅ Detected: JavaScript/TypeScript/React"
    fi
    
    if find . -name "*.py" -o -name "requirements.txt" -o -name "pyproject.toml" -o -name "setup.py" -maxdepth 3 | grep -q .; then
        detected_languages+=("python")
        echo "✅ Detected: Python"
    fi
    
    if find . -name "*.php" -o -name "composer.json" -maxdepth 3 | grep -q .; then
        detected_languages+=("php")
        echo "✅ Detected: PHP"
    fi
    
    if [[ ${#detected_languages[@]} -eq 0 ]]; then
        echo "⚠️  No supported languages detected. Proceeding with minimal setup."
    fi
    
    echo "${detected_languages[@]}"
}

# Function to setup JavaScript/React configuration
setup_javascript() {
    echo "🔧 Setting up JavaScript/React configuration..."
    
    # Create .eslintrc.js if it doesn't exist
    if [[ ! -f ".eslintrc.js" ]] && [[ ! -f ".eslintrc.json" ]] && [[ ! -f ".eslintrc.cjs" ]]; then
        curl -s -o .eslintrc.js https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.eslintrc.js
        echo "   ✅ Created .eslintrc.js"
    fi
    
    # Create .prettierrc if it doesn't exist
    if [[ ! -f ".prettierrc" ]] && [[ ! -f ".prettierrc.json" ]] && [[ ! -f "prettier.config.js" ]]; then
        curl -s -o .prettierrc https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.prettierrc
        echo "   ✅ Created .prettierrc"
    fi
    
    # Update package.json scripts
    if [[ -f "package.json" ]]; then
        # Create backup
        cp package.json package.json.backup
        
        # Add quality scripts using jq if available
        if command -v jq &> /dev/null; then
            jq '.scripts += {
              "auto-fix:preview": "eslint . --fix-dry-run --format=compact",
              "auto-fix:apply": "eslint . --fix && prettier --write .",
              "quality:check": "npm run lint && npm run type-check",
              "lint": "eslint . --ext .js,.jsx,.ts,.tsx --max-warnings 0",
              "lint:fix": "eslint . --ext .js,.jsx,.ts,.tsx --fix",
              "type-check": "tsc --noEmit",
              "test:coverage": "npm test -- --coverage --watchAll=false"
            }' package.json > package.json.tmp && mv package.json.tmp package.json
            echo "   ✅ Updated package.json scripts"
        else
            echo "   ⚠️  jq not found. Please manually add quality scripts to package.json"
        fi
    fi
}

# Function to setup Python configuration
setup_python() {
    echo "🔧 Setting up Python configuration..."
    
    # Create pyproject.toml if it doesn't exist
    if [[ ! -f "pyproject.toml" ]]; then
        curl -s -o pyproject.toml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/pyproject.toml
        echo "   ✅ Created pyproject.toml"
    fi
    
    # Create .flake8 if it doesn't exist
    if [[ ! -f ".flake8" ]] && [[ ! -f "setup.cfg" ]]; then
        curl -s -o .flake8 https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.flake8
        echo "   ✅ Created .flake8"
    fi
}

# Function to setup PHP configuration
setup_php() {
    echo "🔧 Setting up PHP configuration..."
    
    # Create .php-cs-fixer.php if it doesn't exist
    if [[ ! -f ".php-cs-fixer.php" ]]; then
        curl -s -o .php-cs-fixer.php https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.php-cs-fixer.php
        echo "   ✅ Created .php-cs-fixer.php"
    fi
    
    # Create phpstan.neon if it doesn't exist
    if [[ ! -f "phpstan.neon" ]] && [[ ! -f "phpstan.neon.dist" ]]; then
        curl -s -o phpstan.neon https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/phpstan.neon
        echo "   ✅ Created phpstan.neon"
    fi
}

# Function to setup pre-commit hooks
setup_precommit() {
    echo "🔧 Setting up pre-commit hooks..."
    
    # Create .pre-commit-config.yaml
    curl -s -o .pre-commit-config.yaml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.pre-commit-config.yaml
    echo "   ✅ Created .pre-commit-config.yaml"
    
    # Install pre-commit hooks if pre-commit is available
    if command -v pre-commit &> /dev/null; then
        echo "🔧 Installing pre-commit hooks..."
        pre-commit install
        echo "   ✅ Pre-commit hooks installed"
    else
        echo "   ⚠️  pre-commit not found. Please install with: pip install pre-commit"
        echo "   📝 Then run: pre-commit install"
    fi
}

# Function to setup AI PR Agent
setup_pr_agent() {
    echo "🤖 Setting up AI PR Agent..."
    
    # Create .pr_agent.toml configuration
    curl -s -o .pr_agent.toml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.pr_agent.toml
    echo "   ✅ Created .pr_agent.toml configuration"
}

# Function to create GitHub workflows directory and files
setup_github_workflows() {
    echo "🔧 Setting up GitHub Actions workflows..."
    
    # Create .github/workflows directory
    mkdir -p .github/workflows
    
    # Download workflow files
    curl -s -o .github/workflows/quality.yml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.github/workflows/quality.yml
    curl -s -o .github/workflows/auto-fix.yml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.github/workflows/auto-fix.yml
    curl -s -o .github/workflows/test-enforcement.yml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.github/workflows/test-enforcement.yml
    curl -s -o .github/workflows/pr-agent.yml https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.github/workflows/pr-agent.yml
    
    echo "   ✅ Created GitHub Actions workflows (including PR Agent)"
}

# Function to create development scripts
setup_dev_scripts() {
    echo "🔧 Setting up development scripts..."
    
    # Create scripts directory
    mkdir -p scripts
    
    # Download scripts
    curl -s -o scripts/test-requirements.sh https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/scripts/test-requirements.sh
    
    # Create auto-fix.sh script
    cat > scripts/auto-fix.sh << 'EOF'
#!/bin/bash
# Safe auto-fix script for all languages

echo "🔧 Running auto-fix for detected languages..."

if [[ -f "package.json" ]]; then
    echo "🟨 JavaScript/TypeScript auto-fix..."
    if command -v npm &> /dev/null; then
        npm run auto-fix:apply 2>/dev/null || (eslint . --fix && prettier --write .)
    fi
fi

if find . -name "*.py" -maxdepth 3 | grep -q .; then
    echo "🐍 Python auto-fix..."
    if command -v black &> /dev/null; then
        black .
    fi
    if command -v isort &> /dev/null; then
        isort .
    fi
fi

if find . -name "*.php" -maxdepth 3 | grep -q .; then
    echo "🐘 PHP auto-fix..."
    if command -v php-cs-fixer &> /dev/null; then
        php-cs-fixer fix
    fi
fi

echo "✅ Auto-fix completed!"
EOF

    # Create quality-check.sh script
    cat > scripts/quality-check.sh << 'EOF'
#!/bin/bash
# Comprehensive quality check for all languages

echo "🔍 Running quality checks..."

exit_code=0

if [[ -f "package.json" ]]; then
    echo "🟨 JavaScript/TypeScript quality check..."
    if command -v npm &> /dev/null; then
        npm run quality:check 2>/dev/null || npm run lint
        if [[ $? -ne 0 ]]; then exit_code=1; fi
    fi
fi

if find . -name "*.py" -maxdepth 3 | grep -q .; then
    echo "🐍 Python quality check..."
    if command -v flake8 &> /dev/null; then
        flake8 .
        if [[ $? -ne 0 ]]; then exit_code=1; fi
    fi
fi

if find . -name "*.php" -maxdepth 3 | grep -q .; then
    echo "🐘 PHP quality check..."
    if command -v php-cs-fixer &> /dev/null; then
        php-cs-fixer fix --dry-run --diff
        if [[ $? -ne 0 ]]; then exit_code=1; fi
    fi
fi

if [[ $exit_code -eq 0 ]]; then
    echo "✅ All quality checks passed!"
else
    echo "❌ Some quality checks failed!"
fi

exit $exit_code
EOF
    
    # Make scripts executable
    chmod +x scripts/*.sh
    
    echo "   ✅ Created development scripts"
}

# Function to create IDE configuration files
setup_ide_configs() {
    echo "🔧 Setting up IDE configurations..."
    
    # Create .vscode directory and settings
    mkdir -p .vscode
    
    # Download VS Code configurations
    curl -s -o .vscode/settings.json https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.vscode/settings.json
    curl -s -o .vscode/extensions.json https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/.vscode/extensions.json
    
    echo "   ✅ Created IDE configurations"
}

# Function to create documentation
setup_documentation() {
    echo "📝 Creating documentation..."
    
    # Download documentation
    curl -s -o QUALITY_AUTOMATION.md https://raw.githubusercontent.com/nydamon/github-actions-quality-automation-template/main/QUALITY_AUTOMATION.md
    
    echo "   ✅ Created QUALITY_AUTOMATION.md"
}

# Function to show OpenAI setup instructions
show_openai_setup() {
    echo ""
    echo "🤖 AI PR Agent Setup Required:"
    echo "================================="
    echo "To enable automatic PR descriptions and AI code review:"
    echo ""
    echo "1. Get OpenAI API Key:"
    echo "   📋 Visit: https://platform.openai.com/api-keys"
    echo ""
    echo "2. Add to Repository Secrets:"
    echo "   🔐 Go to: Settings → Secrets and variables → Actions"
    echo "   ➕ Add secret: OPENAI_API_KEY"
    echo ""
    echo "3. The PR Agent will automatically:"
    echo "   ✨ Generate comprehensive PR descriptions"
    echo "   🔍 Provide AI-powered code reviews"
    echo "   💡 Suggest code improvements"
    echo "   💬 Answer questions about your code"
    echo ""
    echo "4. Available PR commands:"
    echo "   /describe  - Generate PR description"
    echo "   /review    - AI code review"
    echo "   /improve   - Code suggestions"
    echo "   /ask       - Ask questions about code"
    echo ""
}

# Main execution
echo "🔍 Detecting project languages..."
languages=$(detect_languages)
echo ""

# Setup based on detected languages
for language in $languages; do
    case $language in
        "javascript")
            setup_javascript
            ;;
        "python")
            setup_python
            ;;
        "php")
            setup_php
            ;;
    esac
done

# Setup common components
setup_precommit
setup_pr_agent
setup_github_workflows
setup_dev_scripts
setup_ide_configs
setup_documentation

echo ""
echo "🎉 GitHub Actions Quality Automation setup completed!"
echo "====================================================="
echo ""
echo "✅ What was set up:"
echo "   - Language-specific configurations"
echo "   - Pre-commit hooks"
echo "   - GitHub Actions workflows"
echo "   - AI PR Agent configuration"
echo "   - Development scripts"
echo "   - IDE configurations"
echo "   - Documentation"
echo ""
echo "🚀 Next steps:"
echo "   1. Review and customize configurations for your project"
echo "   2. Install pre-commit: pip install pre-commit && pre-commit install"
echo "   3. Set up OpenAI API key (see instructions below)"
echo "   4. Run quality check: ./scripts/quality-check.sh"
echo "   5. Read the guide: cat QUALITY_AUTOMATION.md"

show_openai_setup

echo ""
echo "💡 Need help? Check QUALITY_AUTOMATION.md for detailed instructions!"
echo "🔗 Template repo: https://github.com/nydamon/github-actions-quality-automation-template"
