{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/catalogCategory.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a category of the catalog.
 *
 * @uses $category Category Current category being viewed
 * @uses $publishedSubmissions array List of published submissions in this category
 * @uses $parentCategory Category Parent category if one exists
 * @uses $subcategories array List of subcategories if they exist
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published submissions in this category
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$category->getLocalizedTitle()|escape}

{* Image and description *}
{assign var="image" value=$category->getImage()}
{assign var="description" value=$category->getLocalizedDescription()|strip_unsafe_html}
<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
    {if $image}
        <a href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="fullSize" type="category" id=$category->getId()}">
            <img class="ammonite-category-full-width-image mt-4"
                src="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="fullSize" type="category" id=$category->getId()}"
                alt="null" />
        </a>
    {/if}

    {include file="frontend/components/breadcrumbs_catalog.tpl" type="category" parent=$parentCategory currentTitle=$category->getLocalizedTitle()}

    <div class="row mt-4">
        <div class="col-12 max-w-sm-900">
            <h1 class="ammonite-h1-text mb-1">
                {$category->getLocalizedTitle()|escape}
            </h1>
        </div>
    </div>

    <div class="row {if $total gt 0}mt-4 mb-5{/if}">
        <div class="col-12 max-w-sm-900 mb-4">
            <span class="ammonite-regular-text">
                {$description|strip_unsafe_html}
            </span>
        </div>
    </div>

    <div class="row mb-5 mb-sm-3">
        <div class="col-12 d-flex justify-content-end">
            <span class="ammonite-breadcrumb-text" style="font-weight: var(--font-weight-bold)!important;">
                {translate key="catalog.browseTitles" numTitles=$total}
            </span>
        </div>
    </div>

    {if $subcategories|@count}
        <div class="row mb-5">
            {foreach from=$subcategories item=subcategory}
                <div class="col-12 col-md-6 col-xl-4 mb-2">
                    <a href="{url op="category" path=$subcategory->getPath()}">
                        <div class="ammonite-secondary-button ammonite-breadcrumb-text text-decoration-none py-2 px-3 d-flex justify-content-center text-center"
                            style="font-weight: var(--font-weight-bold)!important;">
                            {$subcategory->getLocalizedTitle()|escape}
                        </div>
                    </a>
                </div>
            {/foreach}
        </div>
    {/if}

    <div>
        {* No published titles in this category *}
        {if empty($publishedSubmissions)}
            <span class="ammonite-regular-text">{translate key="catalog.category.noItems"}</span>
        {else}
            {foreach from=$publishedSubmissions item=article}
                {include file="frontend/objects/article_summary.tpl" article=$article hideGalleys=true}
            {/foreach}

            {* Pagination *}
            {capture assign=currentPage}{$prevPage+1}{/capture}
            {capture assign=firstPageUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}{/capture}
            {capture assign=lastPage}{math equation="ceil($total / ($showingEnd - $showingStart + 1))"}{/capture}
            {capture assign=lastPageUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$lastPage}{/capture}

            {if $prevPage > 1}
                {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$prevPage}{/capture}
            {elseif $prevPage === 1}
                {capture assign=prevUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}{/capture}
            {/if}
            {if $total > $showingEnd}
                {capture assign=nextUrl}{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|to_array:$nextPage}{/capture}
            {/if}

            {include
                file="frontend/components/pagination.tpl"
                firstPageUrl=$firstPageUrl
                lastPageUrl=$lastPageUrl
                prevUrl=$prevUrl
                nextUrl=$nextUrl
                showingStart=$showingStart
                showingEnd=$showingEnd
                currentPage=$currentPage
                lastPage=$lastPage
                total=$total
            }
        {/if}
    </div>
</div>

{include file="frontend/components/footer.tpl"}
