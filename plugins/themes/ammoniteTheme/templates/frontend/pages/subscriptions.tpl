{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/subscriptions.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * About the Journal Subscriptions.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="about.subscriptions"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.subscriptions"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">{translate key="about.subscriptions"}</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/subscriptionContact.tpl"}
		</div>
	</div>

	{if $individualSubscriptionTypes|@count}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.subscriptions.individual"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900">
				<span class="ammonite-regular-text">{translate key="subscriptions.individualDescription"}</span>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 max-w-sm-900">
				<table class="table align-middle">
					<thead>
						<tr class="ammonite-regular-text mb-0">
							<th scope="col">{translate key="about.subscriptionTypes.name"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.format"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.duration"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.cost"}</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$individualSubscriptionTypes item=subscriptionType}
							<tr class="ammonite-regular-text mb-0">
								<td>
									<p>{$subscriptionType->getLocalizedName()|escape}</p>
									{$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
								</td>
								<td>{translate key=$subscriptionType->getFormatString()}</td>
								<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
								<td>
									{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
		</div>

		{if $isUserLoggedIn}
			<div class="row justify-content-center mb-5">
				<div class="col-12 max-w-sm-900">
					<a class="fw-semibold ammonite-regular-text"
						href="{url page="user" op="purchaseSubscription" path="individual"}">
						{translate key="user.subscriptions.purchaseNewSubscription"}
					</a>
				</div>
			</div>
		{/if}
	{/if}

	{if $institutionalSubscriptionTypes|@count}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text">{translate key="about.subscriptions.institutional"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900">
				<span class="ammonite-regular-text">{translate key="subscriptions.institutionalDescription"}</span>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 max-w-sm-900">
				<table class="table align-middle">
					<thead>
						<tr class="ammonite-regular-text mb-0">
							<th scope="col">{translate key="about.subscriptionTypes.name"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.format"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.duration"}</th>
							<th scope="col">{translate key="about.subscriptionTypes.cost"}</th>
						</tr>
					</thead>
					<tbody>
						{foreach from=$institutionalSubscriptionTypes item=subscriptionType}
							<tr class="ammonite-regular-text mb-0">
								<td>
									<p>{$subscriptionType->getLocalizedName()|escape}</p>
									{$subscriptionType->getLocalizedDescription()|strip_unsafe_html}
								</td>
								<td>{translate key=$subscriptionType->getFormatString()}</td>
								<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
								<td>
									{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
		</div>

		{if $isUserLoggedIn}
			<div class="row">
				<div class="col-12 max-w-sm-900">
					<a class="fw-semibold ammonite-regular-text"
						href="{url page="user" op="purchaseSubscription" path="institutional"}">
						{translate key="user.subscriptions.purchaseNewSubscription"}
					</a>
				</div>
			</div>
		{/if}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
