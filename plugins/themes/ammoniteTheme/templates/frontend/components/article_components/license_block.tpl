{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/article_components/license_block.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief The license block for the article left column
 *
 * @uses $publication object The publication object
 * @uses $currentContext object The current context
 * @uses $ccLicenseBadge string The CC license badge HTML
 * @uses $isDesktop boolean Whether the license block should be displayed on desktop
 *}

<div class="row mx-0 {if $isDesktop}px-0{/if} mb-2 pt-1 ammonite-article-left-column-box">
    <span class="ammonite-heading-text mb-2">{translate key="submission.license"}</span>

    <div class="ammonite-breadcrumb-text mb-0">
        {if $publication->getData('licenseUrl')}
            {if $ccLicenseBadge}
                {if $publication->getLocalizedData('copyrightHolder')}
                    <p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}</p>
                {/if}
                {$ccLicenseBadge}
            {else}
                <a class="fw-semibold text-decoration-none" href="{$publication->getData('licenseUrl')|escape}">
                    {if $publication->getLocalizedData('copyrightHolder')}
                        {translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
                    {else}
                        {translate key="submission.license"}
                    {/if}
                </a>
            {/if}
        {/if}
    </div>

    <div class="ammonite-license ammonite-breadcrumb-text">
        {$currentContext->getLocalizedData('licenseTerms')|strip_unsafe_html}
    </div>
</div>
