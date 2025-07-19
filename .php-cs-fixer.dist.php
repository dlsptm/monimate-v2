<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__ . '/src')
    ->in(__DIR__ . '/tests')
    ->exclude('var')
;

return (new PhpCsFixer\Config())
    ->setParallelConfig(PhpCsFixer\Runner\Parallel\ParallelConfigFactory::detect())
    ->setRules([
        '@Symfony' => true,
        '@Symfony:risky' => true,
        'concat_space' => ['spacing' => 'one'],
        'native_function_invocation' => [
            'include' => ['@compiler_optimized'],
            'scope' => 'all',
            'strict' => true,
        ],
        'ordered_class_elements' => [
            'order' => [
                'use_trait',
                'public',
                'protected',
                'private',
                'constant',
                'constant_public',
                'constant_protected',
                'constant_private',
                'property',
                'property_static',
                'property_public',
                'property_protected',
                'property_private',
                'property_public_static',
                'property_protected_static',
                'property_private_static',
                'construct',
                'destruct',
                'magic',
                'method',
                'method_abstract',
                'method_public_abstract',
                'method_protected_abstract',
                'method_public_abstract_static',
                'method_protected_abstract_static',
                'method_public_static',
                'method_protected_static',
                'method_private_static',
                'method_static',
                'method_public',
                'method_protected',
                'method_private',
                'phpunit',
            ],
            'sort_algorithm' => 'alpha',
        ],
        'ordered_interfaces' => [
            'order' => 'alpha',
        ],
        'yoda_style' => false,
        'no_unused_imports' => true,
        'no_extra_blank_lines' => true,
        'class_attributes_separation' => true,
        'braces_position' => true,
        'single_quote' => true,
    ])
    ->setFinder($finder)
;
