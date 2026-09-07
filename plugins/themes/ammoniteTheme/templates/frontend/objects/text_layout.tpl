{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/objects/text_layout.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Object to use on Text Pages
 *    (about/aboutThisPublishingSystem/editorialTeam/information/custom pages/privacy/submissions)
 *
 * @uses $title text to show on Title
 * @uses $content text to show on content
 *
 *}

<div class="row mt-4">
	<div class="col-12 max-w-sm-900">
		<h1 class="ammonite-h1-text">
			{$title|escape}
		</h1>
	</div>
</div>

<div class="row">
	<div class="col-12 max-w-sm-900">
		<span class="ammonite-regular-text">
			{$content|strip_unsafe_html}
		</span>
	</div>
</div>
