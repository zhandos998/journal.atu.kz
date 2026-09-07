{**
 * @file plugins/themes/ammoniteTheme/templates/common/formErrors.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief List errors that occurred during form processing.
 *}
{if $isError}
	<div class="alert alert-danger" role="alert">
		<h5 class="alert-heading">{translate key="form.errorsOccurred"}:</h5>
		<ul>
			{foreach key=field item=message from=$errors}
				<li><a href="#{$field|escape}" class="alert-link">{$message}</a></li>
			{/foreach}
		</ul>
	</div>
	<script>
		{literal}
			window.location.hash = "formErrors";
		{/literal}
	</script>
{/if}
