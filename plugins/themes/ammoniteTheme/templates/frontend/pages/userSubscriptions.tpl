{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/userSubscriptions.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Page where users can view and manage their subscriptions.
 *
 * @uses $paymentsEnabled boolean
 * @uses $individualSubscriptionTypesExist boolean Have any individual
 *       subscription types been created?
 * @uses $userIndividualSubscription IndividualSubscription
 * @uses $institutionalSubscriptionTypesExist boolean Have any institutional
 *			subscription types been created?
 * @uses $userInstitutionalSubscriptions array
 *}
{include file="frontend/components/header.tpl" pageTitle="user.subscriptions.mySubscriptions"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.subscriptions.mySubscriptions"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key="user.subscriptions.mySubscriptions"}
			</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900">
			{include file="frontend/components/subscriptionContact.tpl"}
		</div>
	</div>

	{if $paymentsEnabled}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text mt-5">{translate key="user.subscriptions.subscriptionStatus"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900">
				<span class="ammonite-regular-text">{translate key="user.subscriptions.statusInformation"}</span>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 max-w-sm-900">
				<table class="table align-middle">
					<thead>
						<tr class="ammonite-regular-text mb-0">
							<th scope="col">{translate key="user.subscriptions.status"}</th>
							<th scope="col">{translate key="user.subscriptions.statusDescription"}</th>
						</tr>
					</thead>

					<tbody>
						<tr class="ammonite-regular-text mb-0">
							<td>{translate key="subscriptions.status.needsInformation"}</td>
							<td>{translate key="user.subscriptions.status.needsInformationDescription"}</td>
						</tr>
						<tr class="ammonite-regular-text mb-0">
							<td>{translate key="subscriptions.status.needsApproval"}</td>
							<td>{translate key="user.subscriptions.status.needsApprovalDescription"}</td>
						</tr>
						<tr class="ammonite-regular-text mb-0">
							<td>{translate key="subscriptions.status.awaitingManualPayment"}</td>
							<td>{translate key="user.subscriptions.status.awaitingManualPaymentDescription"}</td>
						</tr>
						<tr class="ammonite-regular-text mb-0">
							<td>{translate key="subscriptions.status.awaitingOnlinePayment"}</td>
							<td>{translate key="user.subscriptions.status.awaitingOnlinePaymentDescription"}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	{/if}

	{if $individualSubscriptionTypesExist}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text mt-5">{translate key="user.subscriptions.individualSubscriptions"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900">
				<span class="ammonite-regular-text">{translate key="subscriptions.individualDescription"}</span>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 max-w-sm-900">
				{if $userIndividualSubscription}
					<table class="table align-middle">
						<thead>
							<tr class="ammonite-regular-text mb-0">
								<th scope="col">{translate key="user.subscriptions.form.typeId"}</th>
								<th scope="col">{translate key="subscriptions.status"}</th>
								{if $paymentsEnabled}
									<th scope="col"></th>
								{/if}
							</tr>
						</thead>
						<tbody>
							<tr class="ammonite-regular-text mb-0">
								<td>{$userIndividualSubscription->getSubscriptionTypeName()|escape}</td>
								<td>
									{assign var="subscriptionStatus" value=$userIndividualSubscription->getStatus()}
									{assign var="isNonExpiring" value=$userIndividualSubscription->isNonExpiring()}
									{if $paymentsEnabled && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_ONLINE_PAYMENT}
										<span class="subscription_disabled">
											{translate key="subscriptions.status.awaitingOnlinePayment"}
										</span>
									{elseif $paymentsEnabled && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_MANUAL_PAYMENT}
										<span class="subscription_disabled">
											{translate key="subscriptions.status.awaitingManualPayment"}
										</span>
									{elseif $subscriptionStatus != $smarty.const.SUBSCRIPTION_STATUS_ACTIVE}
										<span class="subscription_disabled">
											{translate key="subscriptions.inactive"}
										</span>
									{else}
										{if $isNonExpiring}
											{translate key="subscriptionTypes.nonExpiring"}
										{else}
											{assign var="isExpired" value=$userIndividualSubscription->isExpired()}
											{if $isExpired}
												<span class="subscription_disabled">
													{translate key="user.subscriptions.expired" date=$userIndividualSubscription->getDateEnd()|date_format:$dateFormatShort}
												</span>
											{else}
												<span class="subscription_active">
													{translate key="user.subscriptions.expires" date=$userIndividualSubscription->getDateEnd()|date_format:$dateFormatShort}
												</span>
											{/if}
										{/if}
									{/if}
								</td>
								{if $paymentsEnabled}
									<td>
										{if $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_ONLINE_PAYMENT}
											<a class="ammonite-secondary-button py-2 px-3"
												href="{url op="completePurchaseSubscription" path="individual"|to_array:$userIndividualSubscription->getId()}">
												{translate key="user.subscriptions.purchase"}
											</a>
										{elseif $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_ACTIVE}
											{if !$isNonExpiring}
												<a class="ammonite-secondary-button py-2 px-3"
													href="{url op="payRenewSubscription" path="individual"|to_array:$userIndividualSubscription->getId()}">
													{translate key="user.subscriptions.renew"}
												</a>
											{/if}
											<a class="ammonite-secondary-button py-2 px-3"
												href="{url op="purchaseSubscription" path="individual"|to_array:$userIndividualSubscription->getId()}">
												{translate key="user.subscriptions.purchase"}
											</a>
										{/if}
									</td>
								{/if}
							</tr>
						</tbody>
					</table>
				{elseif $paymentsEnabled}
					<a class="fw-semibold ammonite-regular-text" href="{url op="purchaseSubscription" path="individual"}">
						{translate key="user.subscriptions.purchaseNewSubscription"}
					</a>
				{else}
					<a class="fw-semibold ammonite-regular-text"
						href="{url page="about" op="subscriptions" anchor="subscriptionTypes"}">
						{translate key="user.subscriptions.viewSubscriptionTypes"}
					</a>
				{/if}
			</div>
		</div>
	{/if}

	{if $institutionalSubscriptionTypesExist}
		<div class="row">
			<div class="col-12 max-w-sm-900">
				<h2 class="ammonite-h2-text mt-5">{translate key="user.subscriptions.institutionalSubscriptions"}</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-12 max-w-sm-900">
				<span class="ammonite-regular-text">
					{translate key="subscriptions.institutionalDescription"}
					{if $paymentsEnabled}
						{translate key="subscriptions.institutionalOnlinePaymentDescription"}
					{/if}
				</span>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 max-w-sm-900">
				{if $userInstitutionalSubscriptions}
					<table class="table align-middle">
						<thead>
							<tr class="ammonite-regular-text">
								<th scope="col">{translate key="user.subscriptions.form.typeId"}</th>
								<th scope="col">{translate key="user.subscriptions.form.institutionName"}</th>
								<th scope="col">{translate key="subscriptions.status"}</th>
								{if $paymentsEnabled}
									<th scope="col"></th>
								{/if}
							</tr>
						</thead>

						<tbody>
							{iterate from=userInstitutionalSubscriptions item=userInstitutionalSubscription}
							<tr class="ammonite-regular-text">
								<td>{$userInstitutionalSubscription->getSubscriptionTypeName()|escape}</td>
								<td>{$userInstitutionalSubscription->getInstitutionName()|escape}</td>
								<td>
									{assign var="subscriptionStatus" value=$userInstitutionalSubscription->getStatus()}
									{assign var="isNonExpiring" value=$userInstitutionalSubscription->isNonExpiring()}
									{if $paymentsEnabled && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_ONLINE_PAYMENT}
										<span class="subscription_disabled">
											{translate key="subscriptions.status.awaitingOnlinePayment"}
										</span>
									{elseif $paymentsEnabled && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_MANUAL_PAYMENT}
										<span class="subscription_disabled">
											{translate key="subscriptions.status.awaitingManualPayment"}
										</span>
									{elseif $paymentsEnabled && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_NEEDS_APPROVAL}
										<span class="subscription_disabled">
											{translate key="subscriptions.status.needsApproval"}
										</span>
									{elseif $subscriptionStatus != $smarty.const.SUBSCRIPTION_STATUS_ACTIVE}
										<span class="subscription_disabled">
											{translate key="subscriptions.inactive"}
										</span>
									{else}
										{if $isNonExpiring}
											<span class="subscription_active">
												{translate key="subscriptionTypes.nonExpiring"}
											</span>
										{else}
											{assign var="isExpired" value=$userInstitutionalSubscription->isExpired()}
											{if $isExpired}
												<span class="subscription_disabled">
													{translate key="user.subscriptions.expired" date=$userInstitutionalSubscription->getDateEnd()|date_format:$dateFormatShort}
												</span>
											{else}
												<span class="subscription_enabled">
													{translate key="user.subscriptions.expires" date=$userInstitutionalSubscription->getDateEnd()|date_format:$dateFormatShort}
												</span>
											{/if}
										{/if}
									{/if}
								</td>
								{if $paymentsEnabled}
									<td>
										{if $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_ONLINE_PAYMENT}
											<a class="ammonite-secondary-button py-2 px-3"
												href="{url op="completePurchaseSubscription" path="institutional"|to_array:$userInstitutionalSubscription->getId()}">
												{translate key="user.subscriptions.purchase"}
											</a>
										{elseif $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_ACTIVE}
											{if !$isNonExpiring}
												<a class="ammonite-secondary-button py-2 px-3"
													href="{url op="payRenewSubscription" path="institutional"|to_array:$userInstitutionalSubscription->getId()}">
													{translate key="user.subscriptions.renew"}
												</a>
											{/if}
											<a class="ammonite-secondary-button py-2 px-3"
												href="{url op="purchaseSubscription" path="institutional"|to_array:$userInstitutionalSubscription->getId()}">
												{translate key="user.subscriptions.purchase"}
											</a>
										{/if}
									</td>
								{/if}
							</tr>
							{/iterate}
						</tbody>
					</table>
				{/if}
			</div>

			<div class="row mt-2">
				<div class="col-12 max-w-sm-900">
					{if $paymentsEnabled}
						<a class="fw-semibold ammonite-regular-text"
							href="{url page="user" op="purchaseSubscription" path="institutional"}">
							{translate key="user.subscriptions.purchaseNewSubscription"}
						</a>
					{else}
						<a class="fw-semibold ammonite-regular-text"
							href="{url page="about" op="subscriptions" anchor="subscriptionTypes"}">
							{translate key="user.subscriptions.viewSubscriptionTypes"}
						</a>
					{/if}
				</div>
			</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
