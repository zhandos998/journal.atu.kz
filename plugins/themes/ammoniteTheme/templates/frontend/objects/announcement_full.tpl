{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/announcement_full.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the full view of an announcement, when the announcement is
 *  the primary element on the page.
 *
 * @uses $announcement Announcement The announcement to display
 *}

<div class="row mt-5">
	<div class="col-12 max-w-sm-900">
		<span class="ammonite-regular-text mb-0">
			{$announcement->datePosted|date_format:$dateFormatLong}
		</span>
	</div>
</div>

<div class="row mt-4">
	<div class="col-12 max-w-sm-900">
		<h1 class="ammonite-h1-text">
			{$announcement->getLocalizedData('title')|escape}
		</h1>
	</div>
</div>

<div class="row mt-4">
	<div class="col-12 max-w-sm-900">
		<span class="ammonite-regular-text ammonite-announcement-summary">
			{if $announcement->getLocalizedData('description')}
				{$announcement->getLocalizedData('description')|strip_unsafe_html}
			{else}
				{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
			{/if}
		</span>
	</div>
</div>
