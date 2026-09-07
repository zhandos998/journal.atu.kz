{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_components/keywords_block.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief The keywords block for the article left column
 *
 * @uses $keywords array List of keywords
 * @uses $isDesktop boolean Whether the keywords block should be displayed on desktop
 *}

<div class="row mx-0 {if $isDesktop}px-0{/if} my-2 pt-1 ammonite-article-left-column-box">
    <span class="ammonite-heading-text mb-2">{translate key="common.keywords"}</span>

    <p class="ammonite-breadcrumb-text mb-3">
        {foreach name="keywords" from=$keywords item="keyword"}
            {$keyword|escape}{if !$smarty.foreach.keywords.last}{translate key="common.commaListSeparator"}{/if}
        {/foreach}
    </p>
</div>
