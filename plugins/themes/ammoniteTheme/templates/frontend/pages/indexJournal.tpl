{**
* @file plugins/themes/ammoniteTheme/templates/frontend/pages/indexJournal.tpl
*
* Copyright (c) 2026 Simon Fraser University
* Copyright (c) 2026 John Willinsky
* Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
*
* @brief Display the index page for a journal
*
* @uses $currentJournal Journal This journal
* @uses $journalDescription string Journal description from HTML text editor
* @uses $homepageImage object Image to be displayed on the homepage
* @uses $additionalHomeContent string Arbitrary input from HTML text editor
* @uses $announcements array List of announcements
* @uses $numAnnouncementsHomepage int Number of announcements to display on the
*       homepage
* @uses $issue Issue Current issue
*}

{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="ammonite-hero-section max-w-xl-1200 mx-0 mx-xl-auto"
    style='background-image: url({if !$homepageImage}"https://source.unsplash.com/random/1920x1080/?library"{else}{$baseUrl}/public/journals/{$currentContext->getId()}/{$homepageImage.uploadName|escape:"url"}{/if})'>
    <div class="row max-w-xl-1200 mx-0 mx-xl-auto justify-content-center ammonite-inner-hero-section">
        <div class="col-12 col-lg-10 px-0" style="z-index: 2;">
            <h1 class="ammonite-hero-main-text">{$currentJournal->getLocalizedDescription()|strip_unsafe_html}</h1>
        </div>

        <div class="col-12 col-lg-10 px-0 mt-2 mt-md-3" style="z-index: 2;">
            <div class="row justify-content-between align-items-center mx-0">
                <div class="col-8 col-sm-6 col-xl-4 ps-0 ammonite-hero-subheading-text">
                    <div class="ammonite-additional-home-content-text ammonite-breadcrumb-text mb-0">
                        {$currentJournal->getLocalizedData("additionalHomeContent")|strip_unsafe_html}
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-4 d-flex justify-content-start justify-content-sm-end my-4 my-sm-0 px-0"
                    style="z-index: 2;">
                    <a href="{url router=$smarty.const.ROUTE_PAGE page="about" op="submissions" }"
                        class="ammonite-primary-button px-3 px-md-5 submit-a-manuscript-button">
                        {translate key="plugins.themes.ammonite.submitManuscript"}
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

{foreach from=$categories item="category"}
    {include file="frontend/components/index_category_section.tpl" category=$category categorySubmissions=$categorySubmissions[$category@index]}
{/foreach}

{if $issue}
{include file="frontend/objects/issue_toc.tpl" calledByIndex=true calledByIssuePage=false}
{/if}

{if !!$currentJournal->getLocalizedData('authorInformation')
    || ($activeTheme->getOption('homepageInformationBlockTitle') && $activeTheme->getOption('homepageInformationBlockContent'))
    || !!$currentJournal->getLocalizedData('readerInformation')
    || !!$currentJournal->getLocalizedData('librarianInformation')
}
{include file="frontend/components/index_information_section.tpl"}
{/if}

{include file="frontend/components/index_announcements_section.tpl" announcements=$announcements}

{if $categoryToListSubs}
    <div class="row mx-xl-auto max-w-xl-1200 mx-0 mt-5 main-content-layout">
        <h2 class="ammonite-h2-text ammonite-divider ps-0 ammonite-category-title-anchor">
            <a class="d-flex align-items-center"
                href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$categoryToListSubs->getPath()}">
                {$categoryToListSubs->getLocalizedTitle()|escape}
                <span class="ammonite-link-icon ms-2">></span>
            </a>
        </h2>
    </div>
    <div class="row mx-xl-auto max-w-xl-1200 mx-0 mt-3 main-content-layout">
        {foreach from=$listSubcategories item=subcategory}
            <div class="col-12 col-md-6 col-xl-4 mt-2 ps-0 d-flex align-items-center">
                <a class="ammonite-subcategory-link-text"
                    href="{url page="catalog" op="category" path=$subcategory->getPath()}">
                    {$subcategory->getLocalizedTitle()|escape}
                </a>
            </div>
        {/foreach}
    </div>
{/if}

<div class="row mx-xl-auto max-w-xl-1200 mx-0 mt-4 main-content-layout">
    {call_hook name="Templates::Index::journal"}
</div>

{include file="frontend/components/footer.tpl"}
