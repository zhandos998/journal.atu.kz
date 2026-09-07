{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_components/coverage_block.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief The coverage block for the article left column
 *
 * @uses $coverage string The coverage text
 * @uses $isDesktop boolean Whether the coverage block should be displayed on desktop
 *}

<div class="row mx-0 {if $isDesktop}px-0{/if} my-2 pt-1 ammonite-article-left-column-box">
    <span class="ammonite-heading-text mb-2">{translate key="search.coverage"}</span>

    <p class="ammonite-breadcrumb-text mb-3">
        {$coverage|escape}
    </p>
</div>
