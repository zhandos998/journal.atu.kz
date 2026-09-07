{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_components/type_block.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief The type block for the article left column
 *
 * @uses $type string The type text
 * @uses $isDesktop boolean Whether the type block should be displayed on desktop
 *}

<div class="row mx-0 {if $isDesktop}px-0{/if} my-2 pt-1 ammonite-article-left-column-box">
    <span class="ammonite-heading-text mb-2">{translate key="common.type"}</span>

    <p class="ammonite-breadcrumb-text mb-3">
        {$type|escape}
    </p>
</div>
