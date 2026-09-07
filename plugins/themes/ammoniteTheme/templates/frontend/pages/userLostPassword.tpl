{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login.resetPassword"}

	<div class="row mt-4">
		<div class="col-12 max-w-sm-900">
			<h1 class="ammonite-h1-text">
				{translate key="user.login.resetPassword"}
			</h1>
		</div>
	</div>

	<div class="row mt-2 mt-xl-5">
		<div class="col-12 col-xl-7 max-w-sm-900 mt-0 mt-xl-5">
			<span class="ammonite-regular-text">
				{translate key="user.login.resetPasswordInstructions"}
			</span>
		</div>
	</div>

	{if $error}
		<div class="alert alert-danger" role="alert">
			{translate key=$error}
		</div>
	{/if}

	<form id="lostPasswordForm" method="post" action="{url page="login" op="requestResetPassword"}">
		{csrf}

		<div class="row mt-5">
			<div class="col-12 col-xl-7 max-w-sm-900 mt-0 mt-xl-5">
				<label for="email" class="form-label ammonite-label-text">
					{translate key="user.login.registeredEmail"}
					<span aria-hidden="true" style="color: red">*</span>
					<span class="visually-hidden">{translate key="common.required"}</span>
				</label>
				<div class="input-group input-group-lg">
					<input type="email" name="email" id="email" class="form-control ammonite-underlined-input"
						value="{$email|escape}" required aria-required="true" />
				</div>
			</div>
		</div>

		<div class="row align-items-center mt-5 max-w-sm-900">
			<div class="col-10 col-xl-4">
				<button class="ammonite-primary-button py-2 w-100" type="submit">
					{translate key="user.login.resetPassword"}
				</button>
			</div>

			<div class="col-12 col-xl-2 mt-5 mt-xl-0">
				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<a class="ammonite-regular-text text-decoration-underline ms-0 ms-xl-5 mb-0"
						style="font-weight: var(--font-weight-bold)!important;"
						href="{url page="user" op="register" source=$source}">
						{translate key="user.login.registerNewAccount"}
					</a>
				{/if}
			</div>
		</div>
	</form>
</div>

{include file="frontend/components/footer.tpl"}
