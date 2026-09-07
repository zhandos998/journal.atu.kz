{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/announcement_summary.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display a summary view of an announcement
 *
 * @uses $announcement Announcement The announcement to display
 * @uses $heading string HTML heading element, default: h2
 *}

<div class="row max-w-sm-900 ammonite-h3-text">
	<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->id}"
		class="text-decoration-none d-inline-flex flex-nowrap align-items-center">
		<h2 class="ammonite-h3-text">{$announcement->getLocalizedData('title')|escape} <span
				class="ammonite-link-icon ms-2 mt-1">></span></h2>
	</a>
</div>

<div class="row my-2 max-w-sm-900">
	<span class="ammonite-breadcrumb-text">
		{$announcement->datePosted|date_format:$dateFormatLong}
	</span>
</div>

<div class="row my-2 max-w-sm-900">
	<span class="ammonite-breadcrumb-text ammonite-announcement-short">
		{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
	</span>
</div>
