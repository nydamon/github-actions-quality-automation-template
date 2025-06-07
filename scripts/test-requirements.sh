#!/bin/bash

# Test requirements analysis script
# Analyzes code changes and provides testing guidance

set -e

echo "🧪 Analyzing test requirements..."
echo "==================================="

# Function to check if file matches patterns
check_patterns() {
    local file="$1"
    local patterns=("${@:2}")
    
    for pattern in "${patterns[@]}"; do
        if echo "$file" | grep -E "$pattern" >/dev/null; then
            return 0
        fi
    done
    return 1
}

# Get changed files (from git or provided as arguments)
if [[ $# -gt 0 ]]; then
    changed_files="$@"
else
    # Try to get changed files from git
    if git rev-parse --git-dir >/dev/null 2>&1; then
        changed_files=$(git diff --name-only HEAD~1..HEAD 2>/dev/null || git diff --cached --name-only 2>/dev/null || echo "")
    else
        echo "   ⚠️  Not in a git repository and no files provided"
        echo "   Usage: $0 [file1 file2 ...]"
        exit 1
    fi
fi

if [[ -z "$changed_files" ]]; then
    echo "   ℹ️  No changed files detected"
    exit 0
fi

echo "Changed files:"
echo "$changed_files" | sed 's/^/   - /'
echo ""

# Define tier patterns
tier1_patterns=(
    "auth/"
    "authentication/"
    "login/"
    "payment/"
    "billing/"
    "security/"
    "admin/"
    "api/auth"
    "middleware/auth"
    "guards/"
    "permissions/"
)

tier2_patterns=(
    "api/"
    "components/"
    "pages/"
    "views/"
    "controllers/"
    "services/"
    "models/"
    "routes/"
    "utils/"
    "helpers/"
    "lib/"
    "src/"
)

tier3_patterns=(
    "README"
    "CHANGELOG"
    "LICENSE"
    ".md$"
    ".txt$"
    ".json$"
    ".yaml$"
    ".yml$"
    ".xml$"
    "config/"
    "docs/"
    "documentation/"
    ".env"
    ".gitignore"
    "package.json"
    "composer.json"
    "requirements.txt"
)

# Analyze each file
tier="3"
explanation=""
tier1_files=()
tier2_files=()
tier3_files=()

for file in $changed_files; do
    # Check Tier 1 patterns (highest priority)
    if check_patterns "$file" "${tier1_patterns[@]}"; then
        tier="1"
        tier1_files+=("$file")
    # Check Tier 2 patterns (only if not already Tier 1)
    elif [[ "$tier" != "1" ]] && check_patterns "$file" "${tier2_patterns[@]}"; then
        tier="2"
        tier2_files+=("$file")
    # Check Tier 3 patterns
    elif check_patterns "$file" "${tier3_patterns[@]}"; then
        tier3_files+=("$file")
    else
        # If no patterns match, default to Tier 2
        if [[ "$tier" != "1" ]]; then
            tier="2"
            tier2_files+=("$file")
        fi
    fi
done

# Generate report
echo "Classification Results:"
echo "======================"

case $tier in
    "1")
        echo "🔴 **Tier 1 - Critical**"
        echo "   Changes affect authentication, payment, or security code."
        echo "   **Comprehensive testing required:**"
        echo "   - Unit tests for all modified functions"
        echo "   - Integration tests for API endpoints"
        echo "   - Security validation tests"
        echo "   - Edge case coverage"
        echo ""
        echo "   Critical files:"
        printf '   - %s\n' "${tier1_files[@]}"
        ;;
    "2")
        echo "🟡 **Tier 2 - Important**"
        echo "   Changes affect core application logic."
        echo "   **Standard testing required:**"
        echo "   - Unit tests for modified components"
        echo "   - Integration tests for new features"
        echo "   - Error handling tests"
        echo ""
        echo "   Important files:"
        printf '   - %s\n' "${tier2_files[@]}"
        ;;
    "3")
        echo "🟢 **Tier 3 - Optional**"
        echo "   Changes are documentation, configuration, or low-risk."
        echo "   **Testing is optional** but recommended for any logic changes."
        echo ""
        if [[ ${#tier3_files[@]} -gt 0 ]]; then
            echo "   Documentation/config files:"
            printf '   - %s\n' "${tier3_files[@]}"
        fi
        ;;
esac

echo ""

# Check for existing tests
echo "Existing Tests:"
echo "==============="

test_files_found=false

# JavaScript/TypeScript test patterns
if echo "$changed_files" | grep -E '\.(js|jsx|ts|tsx)$' >/dev/null || [[ -f "package.json" ]]; then
    js_tests=$(find . -name "*.test.js" -o -name "*.test.ts" -o -name "*.test.jsx" -o -name "*.test.tsx" -o -name "*.spec.js" -o -name "*.spec.ts" -o -name "*.spec.jsx" -o -name "*.spec.tsx" 2>/dev/null | head -5)
    if [[ -n "$js_tests" ]]; then
        test_files_found=true
        echo "✅ JavaScript/TypeScript tests found:"
        echo "$js_tests" | sed 's/^/   - /'
    fi
fi

# Python test patterns
if echo "$changed_files" | grep -E '\.py$' >/dev/null; then
    py_tests=$(find . -name "test_*.py" -o -name "*_test.py" 2>/dev/null | head -5)
    if [[ -n "$py_tests" ]]; then
        test_files_found=true
        echo "✅ Python tests found:"
        echo "$py_tests" | sed 's/^/   - /'
    fi
fi

# PHP test patterns
if echo "$changed_files" | grep -E '\.php$' >/dev/null; then
    php_tests=$(find . -name "*Test.php" -o -name "*TestCase.php" 2>/dev/null | head -5)
    if [[ -n "$php_tests" ]]; then
        test_files_found=true
        echo "✅ PHP tests found:"
        echo "$php_tests" | sed 's/^/   - /'
    fi
fi

if [[ "$test_files_found" == "false" ]]; then
    echo "⚠️  No existing tests found"
fi

echo ""

# Provide recommendations
echo "Recommendations:"
echo "================"

if [[ "$tier" == "1" || "$tier" == "2" ]]; then
    if [[ "$test_files_found" == "false" ]]; then
        echo "❌ **Action Required**: Tests are needed for these changes"
        echo ""
        echo "Quick commands to get started:"
        echo ""
        echo "# JavaScript/TypeScript"
        echo "npm test"
        echo "npm run test:coverage"
        echo ""
        echo "# Python"
        echo "pytest"
        echo "pytest --cov=src"
        echo ""
        echo "# PHP"
        echo "phpunit"
        echo "vendor/bin/phpunit --coverage-html coverage"
    else
        echo "✅ **Tests Found**: Please ensure your changes are covered"
        echo ""
        echo "Run existing tests:"
        echo "npm test       # JavaScript/TypeScript"
        echo "pytest         # Python"
        echo "phpunit        # PHP"
    fi
else
    echo "ℹ️  **No Action Required**: These changes are low-risk"
    echo "   Testing is optional but recommended for any logic changes"
fi

echo ""
echo "📚 For detailed guidelines, see: QUALITY_AUTOMATION.md"

# Exit with appropriate code
if [[ "$tier" == "1" || "$tier" == "2" ]] && [[ "$test_files_found" == "false" ]]; then
    exit 1
else
    exit 0
fi