{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

<div class="max-w-xl-1200 main-content-layout mx-xl-auto">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}

	<div class="row">
		<h1 class="ammonite-h1-text text-uppercase">{translate key="user.register"}</h1>
	</div>

	<form id="register" method="post" action="{url op="register"}">
		{csrf}

		{include file="common/formErrors.tpl"}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}

		{include file="frontend/components/registrationForm.tpl"}

		<fieldset form="register">
			<div class="row">
				<div class="col-12 max-w-sm-900">
					{* When a user is registering with a specific journal *}
					<fieldset form="register">
						<legend class="visually-hidden">{translate key="user.register"}</legend>
						{if $currentContext}

							{if $currentContext->getData('privacyStatement')}
								{* Require the user to agree to the terms of the privacy policy *}
								<div class="form-check mt-5 mb-3">
									<input type="checkbox" class="form-check-input rounded-0" name="privacyConsent"
										id="privacyConsent" value="1" {if $privacyConsent}checked="checked" {/if}
										{* TODO: See if this should use HTML5 required *} />
									<label class="form-check-label ammonite-regular-text mb-0" for="privacyConsent">
										{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
										{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
									</label>
								</div>
							{/if}
							<div class="form-check my-3">
								<input type="checkbox" class="form-check-input rounded-0" name="emailConsent"
									id="emailConsent" value="1" {if $emailConsent}checked="checked" {/if} />
								<label class="form-check-label ammonite-regular-text mb-0" for="emailConsent">
									{translate key="user.register.form.emailConsent"}
								</label>
							</div>

							{* Allow the user to sign up as a reviewer *}
							{assign var=contextId value=$currentContext->getId()}
							{assign var=userCanRegisterReviewer value=0}
							{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
								{if $userGroup->permitSelfRegistration}
									{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
								{/if}
							{/foreach}
							{if $userCanRegisterReviewer}
								{if $userCanRegisterReviewer > 1}
									<legend>
										{* TODO: See how this legend should be formatted *}
										{translate key="user.reviewerPrompt"}
									</legend>
									{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
								{else}
									{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
								{/if}

								{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
									{if $userGroup->getPermitSelfRegistration()}
										<div class="form-check my-3">
											{assign var="userGroupId" value=$userGroup->getId()}
											<input class="form-check-input rounded-0" type="checkbox"
												name="reviewerGroup[{$userGroupId}]" id="reviewerGroup[{$userGroupId}]" value="1"
												{if in_array($userGroupId, $userGroupIds)} checked="checked" {/if} />
											<label class="form-check-label ammonite-regular-text mb-0"
												for="reviewerGroup[{$userGroupId}]">
												{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedName()}
											</label>
										</div>
									{/if}
								{/foreach}

								<div class="row mt-5">
									<div class="col-12 max-xl-900">
										<label class="form-label ammonite-label-text" for="interests">
											{translate key="user.interests"}
										</label>
										<div class="input-group input-group-lg">
											<input class="form-control ammonite-input" type="text" name="interests"
												id="interests" value="{$interests|escape}" />
										</div>
									</div>
								</div>
							{/if}
						{/if}
					</fieldset>

					{include file="frontend/components/registrationFormContexts.tpl"}

					<fieldset form="register">
						<legend class="visually-hidden">{translate key="user.register"}</legend>
						{* When a user is registering for no specific journal, allow them to
					enter their reviewer interests *}
						{if !$currentContext}
							<div class="row mx-0 mt-4 px-4 max-w-sm-900">
								<div class="col-12">
									<div class="row justify-content-center mb-4">
										<div class="col-10 col-xl-12">
											<label class="form-label ammonite-label-text" for="interests">
												{translate key="user.register.noContextReviewerInterests"}
											</label>
											<div class="input-group input-group-lg">
												<input class="form-control ammonite-input" type="text" name="interests"
													id="interests" value="{$interests|escape}" />
											</div>
										</div>
									</div>

									{* Require the user to agree to the terms of the privacy policy *}
									{if $siteWidePrivacyStatement}
										<div class="row justify-content-center mb-4">
											<div class="col-10 col-xl-12">
												<div class="form-check my-3">
													<input type="checkbox" class="form-check-input rounded-0"
														name="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]"
														id="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" value="1"
														{if $privacyConsent[$smarty.const.CONTEXT_ID_NONE]}checked="checked"
														{/if} {* TODO: See if this should use HTML5 required *} />
													<label class="form-check-label ammonite-regular-text mb-0"
														for="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]">
														{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
														{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
													</label>
												</div>
											</div>
										</div>
									{/if}

									{* Ask the user to opt into public email notifications *}
									<div class="row justify-content-center mb-4">
										<div class="col-10 col-xl-12">
											<div class="form-check my-3">
												<input type="checkbox" class="form-check-input rounded-0"
													name="emailConsent" id="emailConsent" value="1"
													{if $emailConsent}checked="checked" {/if} />
												<label class="form-check-label ammonite-regular-text mb-0"
													for="emailConsent">
													{translate key="user.register.form.emailConsent"}
												</label>
											</div>
										</div>
									</div>
								</div>
							</div>
						{/if}
					</fieldset>
				</div>
			</div>
		</fieldset>


		{* recaptcha spam blocker *}
		{if $reCaptchaHtml}
			<div class="row mt-5">
				<div class="col-12 max-w-sm-900">
					<div>
						{$reCaptchaHtml}
					</div>
				</div>
			</div>
		{/if}

		<div class="row mt-5 max-w-sm-900">
			<div class="col-12">
				<button type="submit" class="ammonite-primary-button px-5 py-2">
					{translate key="user.register"}
				</button>
			</div>
		</div>

		<div class="row mt-5 max-w-sm-900 ammonite-regular-text">
			<div class="col-12">
				<span>{translate key="plugins.themes.healthSciences.register.haveAccount"}</span>

				{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
				<a href="{url page="login" source=$rolesProfileUrl}" class="text-decoration-underline text-uppercase"
					style="font-weight: var(--font-weight-bold)!important;">
					{translate key="plugins.themes.healthSciences.register.loginHere"}
				</a>
			</div>
		</div>
	</form>
</div>

{include file="frontend/components/footer.tpl"}
