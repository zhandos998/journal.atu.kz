{**
 * @file plugins/themes/ammoniteTheme/templates/plugins/generic/htmlArticleGalley/templates/display.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Embedded viewing of a HTML galley.
 *
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{capture assign="pageTitleTranslated"}{translate key="article.pageTitle" title=$galleyPublication->getLocalizedData('title')|escape}{/capture}
{include file="frontend/components/headerHead.tpl"}

<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">
    {* Header wrapper *}
    <header class="d-flex align-items-center flex-nowrap mx-0"
        style="height: 41px; border-bottom: 1px solid var(--color-black);">

        {capture assign="articleUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}

        <div class="d-flex align-items-center" style="width: 40px!important;">
            <a href="{$articleUrl}" class="ammonite-primary-button pb-2 pt-2 px-3" style="height: 40px;">
                <i class="fas fa-solid fa-arrow-left" aria-hidden="true"></i>
            </a>
        </div>

        <div class="d-flex align-items-center ms-2 ammonite-pdf-html-title-row">
            {if !$isLatestPublication}
                <div class="ammonite-breadcrumb-text fw-semibold ms-2" role="alert">
                    {translate key="submission.outdatedVersion" datePublished=$galleyPublication->getData('datePublished')|date_format:$dateFormatLong urlRecentVersion=$articleUrl}
                </div>
                {capture assign="htmlUrl"}
                    {url page="article" op="download" path=$article->getBestId()|to_array:'version':$galleyPublication->getId():$galley->getBestGalleyId() inline=true}
                {/capture}
            {else}
                <a href="{url page="article" op="view" path=$article->getBestId()}"
                    class="ammonite-breadcrumb-text ms-2 fw-semibold text-truncate text-left" style="width: 100%;">
                    {$galleyPublication->getLocalizedData('title')|strip_unsafe_html}
                </a>
                {capture assign="htmlUrl"}
                    {url page="article" op="download" path=$article->getBestId()|to_array:$galley->getBestGalleyId() inline=true}
                {/capture}
            {/if}
        </div>
    </header>

    <div id="htmlContainer" class="galley_view" style="overflow:visible;-webkit-overflow-scrolling:touch">
        <iframe id="htmlGalleyFrame" name="htmlFrame" src="{$htmlUrl}" allowfullscreen webkitallowfullscreen></iframe>
    </div>
    {call_hook name="Templates::Common::Footer::PageFooter"}
</body>

</html>
