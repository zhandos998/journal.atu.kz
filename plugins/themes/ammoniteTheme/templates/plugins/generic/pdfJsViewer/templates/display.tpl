{**
 * @file plugins/themes/ammoniteTheme/templates/plugins/generic/pdfJsViewer/templates/display.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Embedded viewing of a PDF galley.
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{translate key="article.pageTitle" title=$title|escape}</title>

    {load_header context="frontend" headers=$headers}
    {load_stylesheet context="frontend" stylesheets=$stylesheets}
    {load_script context="frontend" scripts=$scripts}
</head>

<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

    {* Header wrapper *}
    <header class="d-flex justify-content-between align-items-center flex-nowrap mx-0" style="height: 40px;">
        <div class="d-flex align-items-center" style="width: 40px!important;">
            <a href="{$parentUrl|escape}" class="ammonite-primary-button py-2 px-3" style="height: 40px;">
                <i class="fas fa-solid fa-arrow-left" aria-hidden="true"></i>
            </a>
        </div>


        <div class="d-flex align-items-center px-0 ms-2 ammonite-pdf-html-title-row">
            <span class="ammonite-breadcrumb-text ms-2 fw-semibold text-truncate text-left" style="width: 100%;">
                {$title|escape}
            </span>
        </div>

        {if !$isLatestPublication}
            <div class="article-page__alert" role="alert">
                {translate key="submission.outdatedVersion"
                                                datePublished=$galleyPublication->getData('datePublished')|date_format:$dateFormatLong
                                                urlRecentVersion=$parentUrl
                                                }
            </div>
        {/if}

        <div class="d-none d-sm-flex align-items-center" style="width: 137px!important;">
            <a href="{$pdfUrl|escape}" class="ammonite-primary-button py-2 px-3" download style="height: 40px;">
                <span class="label">{translate key="common.download"}</span>
                <span class="sr-only">{translate key="common.downloadPdf"}</span>
            </a>
        </div>

        <div class="d-flex d-sm-none align-items-center" style="width: 50px!important;">
            <a href="{$pdfUrl|escape}" class="ammonite-primary-button py-2 px-3" download style="height: 40px;">
                <i class="fas fa-solid fa-download" aria-hidden="true"></i>
                <span class="sr-only">{translate key="common.downloadPdf"}</span>
            </a>
        </div>
    </header>

    <div id="pdfCanvasContainer" class="galley_view">
        <iframe src="{$pluginUrl}/pdf.js/web/viewer.html?file={$pdfUrl|escape:"url"}" width="100%" height="100%"
            style="min-height: 500px; padding-top: 0!important;" allowfullscreen webkitallowfullscreen></iframe>
    </div>

    <script>
        window.onload = function() {
            var header = document.getElementById('header');
            var canvas = document.getElementById('pdfCanvasContainer');
            canvas.style.width = header.offsetWidth + 'px';
        }
    </script>

    {call_hook name="Templates::Common::Footer::PageFooter"}
</body>

</html>
