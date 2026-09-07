{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_components/categories_block.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief The categories block for the article left column
 *
 * @uses $categories array List of categories
 * @uses $isDesktop boolean Whether the categories block should be displayed on desktop
 *}

<div class="row mx-0 {if $isDesktop}px-0{/if} mb-2 pt-1 ammonite-article-left-column-box">
    <span class="ammonite-heading-text mb-2">{translate key="category.category"}</span>

    <ul class="list-unstyled">
        {foreach from=$categories item=category}
            <li>
                <a class="text-decoration-none fw-semibold"
                    href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->path|escape}">
                    {$category->getLocalizedData('title')|escape}
                </a>
            </li>
        {/foreach}
    </ul>
</div>
