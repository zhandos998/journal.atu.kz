{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/index_information_section.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Section to show informations for Readers, Authors, Reviewers and/or Librarians on index page.
 *
 *}

<div class="ammonite-information-block mx-xl-auto max-w-xl-1200">
    <div class="mx-xl-auto max-w-xl-1200 py-4 main-content-layout px-tablet-0 ammonite-information-block-bg-color">
        <div class="row mx-0">
            <h2 class="ammonite-h2-text ps-0">
                {translate key="plugins.themes.ammonite.information"}
            </h2>
        </div>

        <div class="display-grid mx-0 mt-3">
            {if !!$currentJournal->getLocalizedData('authorInformation')}
                <div class="mb-2 mb-xs-0 ps-0 pe-0 pe-md-3">
                    <div class="ammonite-about-information-block py-4 px-3 h-100">
                        <div class="row mb-2">
                            <h3 class="ammonite-h3-text">{translate key="submission.authors"}</h3>
                        </div>

                        <div class="row">
                            <span class="ammonite-regular-text">
                                {$currentJournal->getLocalizedData('authorInformation')|strip_unsafe_html}
                            </span>
                        </div>
                    </div>
                </div>
            {/if}

            {if !!$activeTheme->getOption('homepageInformationBlockTitle') || !!$currentJournal->getLocalizedData('readerInformation')}
                <div class="mb-2 mb-xs-0 ps-0 pe-0 pe-md-3">
                    <div class="ammonite-about-information-block py-4 px-3 h-100">
                        <div class="row mb-2">
                            <h3 class="ammonite-h3-text">
                                {if $activeTheme->getOption('homepageInformationBlockTitle') && $activeTheme->getOption('homepageInformationBlockContent')}
                                    {$activeTheme->getOption('homepageInformationBlockTitle')|escape}
                                {else}
                                    {translate key="user.role.readers"}
                                {/if}
                            </h3>
                        </div>

                        <div class="row">
                            <span class="ammonite-regular-text">
                                {if $activeTheme->getOption('homepageInformationBlockTitle') && $activeTheme->getOption('homepageInformationBlockContent')}
                                    {$activeTheme->getOption('homepageInformationBlockContent')|strip_unsafe_html}
                                {else}
                                    {$currentJournal->getLocalizedData('readerInformation')|strip_unsafe_html}
                                {/if}
                            </span>
                        </div>
                    </div>
                </div>
            {/if}

            {if !!$currentJournal->getLocalizedData('librarianInformation')}
                <div class="mb-2 mb-xs-0 ps-0 pe-0 pe-md-3">
                    <div class="ammonite-about-information-block py-4 px-3 h-100">
                        <div class="row mb-2">
                            <h3 class="ammonite-h3-text">{translate key="plugins.themes.ammonite.librarians"}</h3>
                        </div>

                        <div class="row">
                            <span class="ammonite-regular-text">
                                {$currentJournal->getLocalizedData('librarianInformation')|strip_unsafe_html}
                            </span>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </div>
</div>
