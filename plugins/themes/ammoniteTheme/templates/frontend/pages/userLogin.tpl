{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="row justify-content-center max-w-xl-1200 main-content-layout mx-xl-auto">
    <div class="col-12 col-md-6 ammonite-login-section">
        <div class="row">
            <h1 class="ammonite-h2-text text-uppercase">{translate key="user.login"}</h1>
        </div>

        <div class="row">
            {* A login message may be displayed if the user was redireceted to the
               login page from another request. Examples include if login is required
               before dowloading a file. *}
            {if $loginMessage}
                <p>
                    {translate key=$loginMessage}
                </p>
            {/if}

            {if $error}
                <div class="alert alert-danger" role="alert">
                    {translate key=$error reason=$reason}
                </div>
            {/if}

            {include file="frontend/components/loginForm.tpl" formType = "loginPage"}
        </div>
    </div>
</div>

{include file="frontend/components/footer.tpl"}
