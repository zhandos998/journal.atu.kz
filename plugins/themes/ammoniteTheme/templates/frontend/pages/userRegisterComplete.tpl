{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}
{include file="frontend/components/header.tpl"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$pageTitle}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">{translate key=$pageTitle}</h1>
		</div>
	</div>

	<div class="row">
		<div class="col-12 max-w-sm-900">
			<ul class="ammonite-regular-text">
				{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array) $userRoles)}
					<li>
						<a class="fw-semibold" href="{url page="submissions"}">
							{translate key="user.login.registrationComplete.manageSubmissions"}
						</a>
					</li>
				{/if}

				{if $currentContext}
					<li>
						<a class="fw-semibold" href="{url page="submission" op="wizard"}">
							{translate key="user.login.registrationComplete.newSubmission"}
						</a>
					</li>
				{/if}

				<li>
					<a class="fw-semibold" href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
						{translate key="user.editMyProfile"}
					</a>
				</li>
				<li>
					<a class="fw-semibold" href="{url page="index"}">
						{translate key="user.login.registrationComplete.continueBrowsing"}
					</a>
				</li>
			</ul>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
