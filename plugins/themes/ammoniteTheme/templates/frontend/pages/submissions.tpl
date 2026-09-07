{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key="manager.setup.submissions"}
			</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900 ammonite-regular-text">
			{if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
				{translate key="author.submit.notAccepting"}
			{else}
				<span>
					{if $isUserLoggedIn}
						{capture assign="newSubmission"}
							<a href="{url page="submission" op="wizard"}">
								{translate key="about.onlineSubmissions.newSubmission"}
							</a>
						{/capture}

						{capture assign="viewSubmissions"}
							<a href="{url page="submissions"}">
								{translate key="about.onlineSubmissions.viewSubmissions"}
							</a>
						{/capture}
						{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
					{else}
						{capture assign="login"}
							<a href="{url page="login"}">
								{translate key="about.onlineSubmissions.login"}
							</a>
						{/capture}

						{capture assign="register"}
							<a href="{url page="user" op="register"}">
								{translate key="about.onlineSubmissions.register"}
							</a>
						{/capture}
						{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
					{/if}
				</span>
			{/if}
		</div>
	</div>

	{if $submissionChecklist}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.submissionPreparationChecklist"}</h2>

				<div class="ammonite-regular-text">
					<p>{translate key="about.submissionPreparationChecklist.description"}</p>

					{$submissionChecklist|strip_unsafe_html}
				</div>
			</div>
		</div>

		<div class="row mb-5">
			<div class="col-12 max-w-sm-900">
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/submissionChecklist" sectionTitleKey="about.submissionPreparationChecklist"}
			</div>
		</div>
	{/if}

	{if $currentContext->getLocalizedData('authorGuidelines')}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.authorGuidelines"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900 ammonite-regular-text">
				{$currentContext->getLocalizedData('authorGuidelines')|strip_unsafe_html}
			</div>
		</div>

		<div class="row mb-5">
			<div class="col-12 max-w-sm-900">
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.authorGuidelines"}
			</div>
		</div>
	{/if}

	{foreach from=$sections item="section"}
		{if $section->getLocalizedPolicy()}
			<div class="row">
				<div class="col-12 max-w-sm-900">
					<h2 class="ammonite-h2-text">{$section->getLocalizedTitle()|escape}</h2>
				</div>
			</div>

			<div class="row">
				<div class="col-12 max-w-sm-900 ammonite-regular-text">
					{$section->getLocalizedPolicy()|strip_unsafe_html}

					{if $isUserLoggedIn}
						{capture assign="sectionSubmissionUrl"}{url page="submission" op="wizard" sectionId=$section->getId()}{/capture}
						<p>
							{translate key="about.onlineSubmissions.submitToSection" name=$section->getLocalizedTitle() url=$sectionSubmissionUrl}
						</p>
					{/if}
				</div>
			</div>
		{/if}
	{/foreach}

	{if $currentContext->getLocalizedData('copyrightNotice')}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.copyrightNotice"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900 ammonite-regular-text">
				{$currentContext->getLocalizedData('copyrightNotice')|strip_unsafe_html}
			</div>
		</div>

		<div class="row mb-5">
			<div class="col-12 max-w-sm-900">
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/authorGuidelines" sectionTitleKey="about.copyrightNotice"}
			</div>
		</div>
	{/if}

	{if $currentContext->getLocalizedData('privacyStatement')}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.privacyStatement"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900 ammonite-regular-text">
				{$currentContext->getLocalizedData('privacyStatement')|strip_unsafe_html}
			</div>
		</div>

		<div class="row mb-5">
			<div class="col-12 max-w-sm-900">
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
			</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
