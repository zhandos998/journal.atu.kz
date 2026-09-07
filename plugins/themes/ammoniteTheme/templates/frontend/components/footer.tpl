{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site footer.
 *}

<section class="ammonite-footer mx-xl-auto max-w-xl-1200" style="margin-top: 5rem;">
    <div class="row border-bottom mx-xl-auto max-w-xl-1200 px-5">
        {call_hook name="Templates::Common::Sidebar"}
    </div>

    <div class="d-flex flex-wrap border-bottom mx-xl-auto max-w-xl-1200 px-5">
        {call_hook name="Templates::Common::Footer::PageFooter"}
    </div>

    <div class="row py-5 mx-xl-auto max-w-xl-1200 main-content-layout mx-0 px-tablet-0">
        <div class="col-12 col-md-8">
            <div class="row flex-row-reverse flex-md-row h-100">
                <div class="col-5 d-flex flex-column justify-content-between">
                    {if $footerClientLogo}
                        <div class="row justify-content-center align-items-center mb-5">
                        <a
                            href="{if $activeTheme->getOption('footerClientLogoLink')}{$activeTheme->getOption('footerClientLogoLink')|escape}{else}{url page="index" router=$smarty.const.ROUTE_PAGE}{/if}"
                            class="ps-sm-0"
                        >
                            <img
                                class="img-fluid"
                                width="80%"
                                height="80"
                                src="{$footerClientLogo|escape}"
                                alt="{$activeTheme->getOption('footerClientLogoAltText')|escape}"
                            >
                        </a>
                        </div>
                    {/if}

                    <div class="row justify-content-center align-items-center">
                        <a href="{url page="about" op="aboutThisPublishingSystem"}" class="ps-sm-0">
                            <img class="img-fluid" style="height: 53px;"
                                alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/{$brandImage}">
                        </a>
                    </div>
                </div>

                <div class="col-7 h-100 px-0">
                    {load_menu name="footer" path="frontend/components/footerNavigationMenu.tpl"}
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4 mt-5 mt-md-0 d-flex flex-column-reverse flex-md-column px-0">
            <div class="ammonite-footer-block-text">
                {$currentContext->getLocalizedData('pageFooter')|strip_unsafe_html}
            </div>

            <div class="d-flex align-items-center mt-0 mt-md-5 mb-5 mb-md-0">
                {load_menu name="footerSocialMedia" path="frontend/components/socialMediaFooterNavigationMenu.tpl"}
            </div>
        </div>
    </div>
    </div>
</section>
</div>

{load_script context="frontend"}
</body>

</html>
