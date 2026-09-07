{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/message.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Generic message page.
 * Displays a simple message and (optionally) a return link.
 *}
{include file="frontend/components/header.tpl"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}

	<div class="row mx-0 mt-4 px-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key=$pageTitle}
			</h1>
		</div>
	</div>

	<div class="row mx-0 px-4">
		<div class="col-12 max-w-sm-900">
			<span class="ammonite-regular-text">
				{if $messageTranslated}
					<p>{$messageTranslated|escape}</p>
				{else}
					<p>{translate key=$message}</p>
				{/if}

				{if $backLink}
					<p><a href="{$backLink|escape}">{translate key=$backLinkLabel}</a></p>
				{/if}
			</span>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
