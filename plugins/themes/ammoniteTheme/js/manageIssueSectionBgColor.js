/**
 * @file plugins/themes/ammoniteTheme/js/manageIssueSectionBgColor.js
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class ManageIssueSectionBgColor
 * @ingroup plugins_themes_ammonite
 *
 * @brief Manage issue section background color
 */

window.addEventListener('load', function() {
	const issueCoverImage = document.getElementById('issueCoverImage');
	const ammoniteIssueContentSection = document.querySelector('.ammonite-issue-content-section');

	if (issueCoverImage && issueCoverImage.complete) {
		const canvas = document.createElement('canvas');
		const context = canvas.getContext('2d');

		canvas.width = issueCoverImage.width;
		canvas.height = issueCoverImage.height;

		context.drawImage(issueCoverImage, 0, 0);

		const pixelData = context.getImageData(4, 4, 1, 1).data;
		const rgbColor = 'rgba(' + pixelData[0] + ', ' + pixelData[1] + ', ' + pixelData[2] + ', 0.2' + ')';

		ammoniteIssueContentSection.style.backgroundColor = rgbColor;
	} else {
		issueCoverImage.addEventListener('load', function() {
		const canvas = document.createElement('canvas');
		const context = canvas.getContext('2d');

		canvas.width = issueCoverImage.width;
		canvas.height = issueCoverImage.height;
		context.drawImage(issueCoverImage, 0, 0);

		const pixelData = context.getImageData(4, 4, 1, 1).data;
		const rgbColor = 'rgba(' + pixelData[0] + ', ' + pixelData[1] + ', ' + pixelData[2] + ', 0.2' + ')';

		ammoniteIssueContentSection.style.backgroundColor = rgbColor;
		});
	}
});
