<?php

$finder = PhpCsFixer\Finder::create()
    ->in(__DIR__)
    ->exclude('vendor')
    ->exclude('node_modules')
    ->exclude('storage')
    ->exclude('bootstrap/cache')
    ->exclude('public/build')
    ->exclude('resources/views/cache')
    ->name('*.php')
    ->notName('*.blade.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        '@PhpCsFixer' => true,
        
        // Array formatting
        'array_syntax' => ['syntax' => 'short'],
        'array_indentation' => true,
        'trim_array_spaces' => true,
        'trailing_comma_in_multiline' => [
            'elements' => ['arrays', 'arguments', 'parameters'],
        ],
        
        // Import organization
        'ordered_imports' => [
            'sort_algorithm' => 'alpha',
            'imports_order' => ['class', 'function', 'const'],
        ],
        'no_unused_imports' => true,
        
        // Spacing and formatting
        'not_operator_with_successor_space' => true,
        'binary_operator_spaces' => [
            'default' => 'single_space',
            'operators' => ['=>' => 'align_single_space_minimal'],
        ],
        'unary_operator_spaces' => true,
        'concat_space' => ['spacing' => 'one'],
        
        // Method and function formatting
        'method_argument_space' => [
            'on_multiline' => 'ensure_fully_multiline',
            'keep_multiple_spaces_after_comma' => false,
        ],
        'function_declaration' => [
            'closure_function_spacing' => 'one',
        ],
        
        // Control structure formatting
        'blank_line_before_statement' => [
            'statements' => [
                'break', 'continue', 'declare', 'return', 
                'throw', 'try', 'if', 'switch', 'for', 
                'foreach', 'while', 'do',
            ],
        ],
        'no_superfluous_elseif' => true,
        'no_useless_else' => true,
        
        // PHPDoc formatting
        'phpdoc_align' => [
            'align' => 'vertical',
            'tags' => ['param', 'return', 'throws', 'type', 'var'],
        ],
        'phpdoc_scalar' => true,
        'phpdoc_single_line_var_spacing' => true,
        'phpdoc_var_without_name' => true,
        'phpdoc_summary' => true,
        'phpdoc_trim' => true,
        'phpdoc_trim_consecutive_blank_line_separation' => true,
        
        // Class formatting
        'single_trait_insert_per_statement' => true,
        'class_attributes_separation' => [
            'elements' => [
                'method' => 'one',
                'property' => 'one',
            ],
        ],
        'ordered_class_elements' => [
            'order' => [
                'use_trait',
                'constant_public',
                'constant_protected',
                'constant_private',
                'property_public',
                'property_protected',
                'property_private',
                'construct',
                'destruct',
                'method_public',
                'method_protected',
                'method_private',
            ],
        ],
        
        // String formatting
        'single_quote' => ['strings_containing_single_quote_chars' => false],
        'escape_implicit_backslashes' => true,
        
        // Strict types and return types
        'declare_strict_types' => false,
        'void_return' => true,
        
        // Miscellaneous
        'no_empty_comment' => true,
        'no_empty_phpdoc' => true,
        'no_empty_statement' => true,
        'no_extra_blank_lines' => [
            'tokens' => [
                'extra', 'throw', 'use', 'use_trait',
                'break', 'continue', 'return',
            ],
        ],
        'no_trailing_comma_in_singleline_array' => true,
        'normalize_index_brace' => true,
        'object_operator_without_whitespace' => true,
        'standardize_not_equals' => true,
        'ternary_operator_spaces' => true,
        
        // Disable some overly strict rules
        'yoda_style' => false,
        'increment_style' => false,
        'php_unit_internal_class' => false,
        'php_unit_test_class_requires_covers' => false,
    ])
    ->setFinder($finder)
    ->setUsingCache(true)
    ->setRiskyAllowed(true);