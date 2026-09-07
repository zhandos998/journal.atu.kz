{**
 * @file plugins/themes/ammoniteTheme/templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $givenName string First name input entry if available
 * @uses $familyName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}

<fieldset form="register">
	<legend class="visually-hidden">{translate key="user.register"}</legend>
	<div class="row mt-4 max-w-sm-900">
		<div class="col-12 col-xl-6">
			<div class="row">
				<div class="col-12">
					<h2 class="ammonite-h2-text">{translate key="user.profile"}</h2>
				</div>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="givenName" class="form-label ammonite-label-text">
						{translate key="user.givenName"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="text" name="givenName"
							autocomplete="given-name" id="givenName" value="{$givenName|escape}" maxlength="255"
							required aria-required="true" />
					</div>
				</div>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="familyName" class="form-label ammonite-label-text">
						{translate key="user.familyName"}
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="text" name="familyName"
							autocomplete="family-name" id="familyName" value="{$familyName|escape}" maxlength="255" />
					</div>
				</div>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="affiliation" class="form-label ammonite-label-text">
						{translate key="user.affiliation"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="text" name="affiliation"
							autocomplete="family-name" id="affiliation" value="{$affiliation|escape}" maxlength="255" />
					</div>
				</div>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="country" class="form-label ammonite-label-text">
						{translate key="common.country"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<select class="form-select rounded-0" style="border-color: var(--color-black)" name="country"
							id="country" required aria-required="true">
							<option></option>
							{html_options options=$countries selected=$country}
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="col-12 col-xl-6">
			<div class="row">
				<div class="col-12">
					<h2 class="ammonite-h2-text">{translate key="user.login"}</h2>
				</div>
			</div>

			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="email" class="form-label ammonite-label-text">
						{translate key="user.email"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="email" name="email" autocomplete="email"
							id="email" value="{$email|escape}" maxlength="90" required aria-required="true" />
					</div>
				</div>
			</div>
			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="username" class="form-label ammonite-label-text">
						{translate key="user.username"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="text" name="username" autocomplete="username"
							id="username" value="{$username|escape}" maxlength="32" required aria-required="true" />
					</div>
				</div>
			</div>
			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="password" class="form-label ammonite-label-text">
						{translate key="user.password"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="password" name="password" id="password"
							maxlength="32" required aria-required="true" />
					</div>
				</div>
			</div>
			<div class="row justify-content-center mb-4">
				<div class="col-10 col-xl-12">
					<label for="password2" class="form-label ammonite-label-text">
						{translate key="user.repeatPassword"}
						<span aria-hidden="true" style="color: red">*</span>
						<span class="visually-hidden">{translate key="common.required"}</span>
					</label>
					<div class="input-group input-group-lg">
						<input class="form-control ammonite-input" type="password" name="password2" id="password2"
							maxlength="32" required aria-required="true" />
					</div>
				</div>
			</div>
		</div>
	</div>
</fieldset>
