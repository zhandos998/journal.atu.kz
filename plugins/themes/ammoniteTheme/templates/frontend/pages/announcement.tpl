{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/announcement.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page which represents a single announcement
 *
 * @uses $announcement Announcement The announcement to display
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$announcement->getLocalizedData('title')|escape}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
    {include file="frontend/components/breadcrumbs_announcement.tpl" currentTitle=$announcement->getLocalizedData('title')}

    {include file="frontend/objects/announcement_full.tpl"}
</div>


{include file="frontend/components/footer.tpl"}
