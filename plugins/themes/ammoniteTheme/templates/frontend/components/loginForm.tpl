{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/loginForm.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic login form fields
 *
 * @uses $loginUrl string URL to post the login request
 * @uses $source string Optional URL to redirect to after successful login
 * @uses $username string Username
 * @uses $password string Password
 * @uses $remember boolean Should logged in cookies be preserved on this computer
 * @uses $disableUserReg boolean Can users register for this site?
 *}
{if $formType && $formType === "loginPage"}
    {assign var=usernameId value="username"}
    {assign var=passwordId value="password"}
    {assign var=rememberId value="remember"}
{elseif $formType && $formType === "loginModal"}
    {assign var=usernameId value="usernameModal"}
    {assign var=passwordId value="passwordModal"}
    {assign var=rememberId value="rememberModal"}
{/if}
<form class="form-login" method="post" action="{$loginUrl}">
    {csrf}
    <input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

    <fieldset legend="form-login">
        <legend class="visually-hidden">{translate key="user.login"}</legend>
        <div class="form-group form-group-username">
            <label for="{$usernameId}" class="form-label ammonite-label-text">
                {translate key="user.username"}
                <span class="required" aria-hidden="true" style="color: red">*</span>
                <span class="visually-hidden">
                    {translate key="common.required"}
                </span>
            </label>
            <input type="text" class="form-control ammonite-input ammonite-login-input" name="username"
                id="{$usernameId}" value="{$username|default:""|escape}" maxlength="32" autocomplete="username"
                required>
        </div>
        <div class="form-group form-group-password mb-5">
            <label for="{$passwordId}" class="form-label ammonite-label-text">
                {translate key="user.password"}
                <span class="required" aria-hidden="true" style="color: red">*</span>
                <span class="visually-hidden">
                    {translate key="common.required"}
                </span>
            </label>
            <input type="password" class="form-control ammonite-input ammonite-login-input" name="password"
                id="{$passwordId}" value="{$password|default:""|escape}" maxlength="32" autocomplete="current-password"
                required>
        </div>

        <div class="row">
            <div class="form-group form-group-forgot mb-3">
                <small class="form-text">
                    <a class="text-decoration-underline ammonite-label-text"
                        href="{url page="login" op="lostPassword"}">
                        {translate key="user.login.forgotPassword"}
                    </a>
                </small>
            </div>
        </div>

        <div class="row mx-0">
            <div class="form-group form-check form-group-remember">
                <input type="checkbox" class="form-check-input" name="remember" id="{$rememberId}" value="1"
                    checked="{$remember}">
                <label for="{$rememberId}" class="form-check-label">
                    <small class="form-text ammonite-label-text">
                        {translate key="user.login.rememberUsernameAndPassword"}
                    </small>
                </label>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group form-group-buttons">
                    <button class="ammonite-primary-button w-100 py-2" type="submit">
                        {translate key="user.login"}
                    </button>
                </div>
            </div>
        </div>

        {if !$disableUserReg}
            <div class="row">
                <div class="form-group form-group-register text-start">
                    {translate key="plugins.themes.healthSciences.register.noAccount"}
                    {capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
                    <a href="{$registerUrl}" class="ammonite-breadcrumb-text text-uppercase text-decoration-underline"
                        style="font-weight: var(--font-weight-bold);">
                        {translate key="plugins.themes.healthSciences.register.registerHere"}
                    </a>
                </div>
            </div>
        {/if}
    </fieldset>
</form>
