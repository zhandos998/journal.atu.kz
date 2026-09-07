{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/index_category_section.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Section to show submissions from selected categories on the theme options.
 *
 * @uses $category Category object for title
 * @uses $categorySubmissions Submission list to show.
 *}

<div class="row mx-0 max-w-xl-1200 mx-xl-auto mt-5 main-content-layout">
    <h2 class="ammonite-h2-text ammonite-divider ps-0 ammonite-category-title-anchor">
        <a class="d-flex align-items-center"
            href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()}">
            {$category->getLocalizedData('title')|escape}
            <span class="ammonite-link-icon ms-2">></span>
        </a>
    </h2>
</div>

{if $categorySubmissions && $categorySubmissions|@count > 0}
    <div class="row mx-0 max-w-xl-1200 mx-xl-auto flex-nowrap flex-sm-wrap overflow-auto main-content-layout">
        <div class="col-12 col-sm px-0" style="overflow-y: hidden;">
            <div class="d-flex">
                {foreach from=$categorySubmissions item="submission"}
                    {assign var=publication value=$submission->getCurrentPublication()}
                    {assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
                    {assign var=articlePath value=$submission->getBestId()}
                    <div class="col-10 col-md-4 {if $submission@first}pe-2{elseif $submission@last}ps-2{else}px-2{/if} h-100">
                        {if !is_null($submission->firstSubcategory)}
                            <div class="row mb-2 mx-0">
                                <span class="ammonite-breadcrumb-text px-0">
                                    {$submission->firstSubcategory->getLocalizedData('title')|escape}
                                </span>
                            </div>
                        {/if}
                        {if !!$publication->getLocalizedCoverImageUrl($submission->getData('contextId')) || !!$defaultArticleImage}
                            <div class="row mx-0">
                                <a href="{if $journal}{url journal=$journal->getPath() page='article' op='view' path=$articlePath}{else}{url page='article' op='view' path=$articlePath}{/if}" class="px-0">
                                    <img src="{if !!$coverImage}{$publication->getLocalizedCoverImageUrl($submission->getData('contextId'))|escape}{else}{$defaultArticleImage|escape}{/if}"
										alt="{if !!$coverImage}{$coverImage.altText|escape|default:''}{else}{translate key='plugins.themes.ammonite.noArticleCoverImageAltText'}{/if}" class="w-100 img-cover" style="height: 170px; object-fit: cover; object-position: center;">
                                </a>
                            </div>
                        {else}
                            <div class="row" style="margin-top: calc(1rem + 170px);"></div>
                        {/if}

                        <div class="row mt-3 mx-0">
                            <a href="{if $journal}{url journal=$journal->getPath() page="article" op="view" path=$articlePath}{else}{url page="article" op="view" path=$articlePath}{/if}"
                                class="px-0">
                                <span class="ammonite-category-submission-title-text">
                                    {$publication->getLocalizedData('title')|escape}
                                    {assign var=localizedSubtitle value=$publication->getLocalizedSubtitle(null, 'html')|strip_unsafe_html}
                                    {if $localizedSubtitle}
                                        <span class="subtitle">{$localizedSubtitle}</span>
                                    {/if}
                                </span>
                            </a>
                        </div>

                        {if $publication->getData('authors')}
                            <div class="d-flex flex-wrap align-items-center mt-3 pe-2">
                                {foreach from=$publication->getData('authors') item=author}
                                    {if $author@index lte 2}
                                        <span class="ammonite-breadcrumb-text">
                                            {$author->getFullName()|escape}{if !$author@last && !$author@index lte 2},&nbsp;{/if}
                                        </span>
                                    {/if}
                                {/foreach}
                                {if $publication->getData('authors')|@count > 3}
                                    <span class="ammonite-breadcrumb-text">&nbsp;[...]</span>
                                {/if}
                            </div>
                        {/if}

                        <div class="row mt-3 mb-2 mx-0">
                            <span class="ammonite-breadcrumb-text px-0">
                                {$submission->section->getLocalizedTitle()|escape}
                            </span>
                            <span class="ammonite-breadcrumb-text px-0">
                                {$publication->getData('datePublished')|date_format:$dateFormatLong}
                            </span>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/if}
