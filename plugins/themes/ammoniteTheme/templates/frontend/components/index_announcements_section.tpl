{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/index_announcements_section.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Section to show announcements on index page.
 *
 * @uses $announcements Announcement list to show
 *
 *}

{if $currentContext->getData('enableAnnouncements')}
    <div class="ammonite-announcements-block max-w-xl-1200 mx-xl-auto">
        <div class="max-w-xl-1200 mx-xl-auto py-4 main-content-layout px-tablet-0">
            <div class="row mx-0">
                <h2 class="ammonite-h2-text ammonite-announcements-title ps-1">
                    <a class="d-flex align-items-center" href="{url router=$smarty.const.ROUTE_PAGE page='announcement'}">
                        <span>{translate key="plugins.themes.ammonite.journalNews"}</span>
                        <span class="ammonite-link-icon ms-2">></span>
                    </a>
                </h2>
            </div>

            <div class="display-grid mx-0 mt-3">
                {foreach from=$announcements item="announcement"}
                    {if $announcement@index lte 1}
                        <div class="mb-2 mb-xs-0 pe-0 pe-md-3">
                            <div class="ammonite-announcement-information-block py-4 px-3 h-100 mb-0">
                                <div class="row mb-2">
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page='announcement' op='view' path=$announcement->id}">
                                        <h3 class="ammonite-h3-text">{$announcement->getLocalizedData('title')|escape}</h3>
                                    </a>
                                </div>

                                <div class="row my-4">
                                    <span class="ammonite-breadcrumb-text">
                                        {$announcement->datePosted|date_format:$dateFormatLong}
                                    </span>
                                </div>

                                <div class="row">
                                    <span class="ammonite-regular-text ammonite-index-announcement">
                                        {$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
                                    </span>
                                </div>
                            </div>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
{/if}
