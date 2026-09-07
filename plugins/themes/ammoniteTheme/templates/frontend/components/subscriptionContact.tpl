{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/subscriptionContact.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the contact details for a journal's subscriptions
 *
 * @uses $subscriptionAdditionalInformation string HTML text description
 *       subcription information
 * @uses $subscriptionMailingAddress string Contact address for subscriptions
 * @uses $subscriptionName string Contact name for subscriptions
 * @uses $subscriptionPhone string Contact phone number for subscriptions
 * @uses $subscriptionEmail string Contact email address for subscriptions
 *}

{if $subscriptionAdditionalInformation}
	<span class="ammonite-regular-text">{$subscriptionAdditionalInformation|strip_unsafe_html}</span>
{/if}

{if $subscriptionName || $subscriptionPhone || $subscriptionEmail}
	<h2 class="ammonite-h2-text mt-5">{translate key="about.subscriptionsContact"}</h2>
{/if}

<div class="ammonite-regular-text">
	{if $subscriptionName}
		<div class="d-flex align-items-center mx-0">
			<span class="fw-semibold me-1">{translate key="common.name"}:</span>
			<span>{$subscriptionName|escape}</span>
		</div>
	{/if}

	{if $subscriptionMailingAddress}
		<div class="d-flex align-items-center mx-0">
			<span class="fw-semibold me-1">{translate key="common.mailingAddress"}:</span>
			<span>{$subscriptionMailingAddress|nl2br|strip_unsafe_html}</span>
		</div>
	{/if}

	{if $subscriptionPhone}
		<div class="d-flex align-items-center mx-0">
			<span class="fw-semibold me-1">{translate key="about.contact.phone"}: </span>
			<span>{$subscriptionPhone|escape}</span>
		</div>
	{/if}

	{if $subscriptionEmail}
		<div class="d-flex align-items-center mx-0">
			<span class="fw-semibold me-1">{translate key="about.contact.email"}: </span>
			<span>{mailto address=$subscriptionEmail encode='javascript'}</span>
		</div>
	{/if}
</div>
