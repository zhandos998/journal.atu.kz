{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the press's contact details.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $mailingAddress string Mailing address for the journal/press
 * @uses $contactName string Primary contact name
 * @uses $contactTitle string Primary contact title
 * @uses $contactAffiliation string Primary contact affiliation
 * @uses $contactPhone string Primary contact phone number
 * @uses $contactEmail string Primary contact email address
 * @uses $supportName string Support contact name
 * @uses $supportPhone string Support contact phone number
 * @uses $supportEmail string Support contact email address
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}

<div class="max-w-xl-1200 mx-xl-auto main-content-layout">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.contact"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key="about.contact"}
			</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900">

			{* Primary contact *}
			<div class="row">
				<h2 class="ammonite-h2-text">{translate key="about.contact.principalContact"}</h2>
			</div>

			<div class="ammonite-regular-text">
				{if $contactName}<span class="row mx-0">{$contactName|escape}</span>{/if}
				{if $contactTitle}<span class="row mx-0">{$contactTitle|escape}</span>{/if}
				{if $contactAffiliation}<span class="row mx-0">{$contactAffiliation|strip_unsafe_html}</span>{/if}

				{if $contactPhone}
					<div class="d-flex align-items-center mx-0">
						<span class="fw-semibold me-1">{translate key="about.contact.phone"}:</span>
						<span>{$contactPhone|escape}</span>
					</div>
				{/if}

				{if $contactEmail}
					<div class="d-flex align-items-center mx-0">
						<span class="fw-semibold me-1">{translate key="about.contact.email"}:</span>
						<span>{mailto address=$contactEmail encode='javascript'}</span>
					</div>
				{/if}
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900 mb-5">

			{* Technical Contact *}
			<div class="row">
				<h2 class="ammonite-h2-text">{translate key="about.contact.supportContact"}</h2>
			</div>

			<div class="ammonite-regular-text">
				{if $supportName}<span class="row mx-0">{$supportName|escape}</span>{/if}

				{if $supportPhone}
					<div class="d-flex align-items-center mx-0">
						<span class="fw-semibold me-1">{translate key="about.contact.phone"}:</span>
						<span>{$supportPhone|escape}</span>
					</div>
				{/if}

				{if $supportEmail}
					<div class="d-flex align-items-center mx-0">
						<span class="fw-semibold me-1">{translate key="about.contact.email"}:</span>
						<span>{mailto address=$supportEmail encode='javascript'}</span>
					</div>
				{/if}
			</div>
		</div>
	</div>

	{if $mailingAddress}
		<div class="row">
			<h2 class="ammonite-h2-text">{translate key="common.mailingAddress"}</h2>
		</div>

		<div class="row">
			<span class="ammonite-regular-text">
				{$mailingAddress|nl2br|strip_unsafe_html}
			</span>
		</div>
	{/if}

	<div class="row">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
