<?php

/**
 * @file plugins/themes/ammoniteTheme/classes/PublisherLibraryManager.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class PublisherLibraryManager
 * @ingroup plugins_themes_ammonite
 *
 * @brief Publisher library manager
 */

namespace APP\plugins\themes\ammoniteTheme\classes;

use PKP\context\Context;
use PKP\context\LibraryFile;
use PKP\context\LibraryFileDAO;
use PKP\db\DAORegistry;

class PublisherLibraryManager
{
    /**
     * Retrieves library publisher files as options array
     *
     * @return array<int, array{value: int, label: string}>
     */
    public static function getPublisherLibraryFiles(?Context $context): array
    {
        if ($context == null) {
            return [];
        }

        /** @var LibraryFileDAO $libraryFileDao */
        $libraryFileDao = DAORegistry::getDAO('LibraryFileDAO');
        $libraryFiles = $libraryFileDao->getByContextId($context->getId(), LibraryFile::LIBRARY_FILE_TYPE_OTHER);

        $options = [];
        while ($libraryFile = $libraryFiles->next()) {
            $options[] = [
                'value' => $libraryFile->getId(),
                'label' => $libraryFile->getLocalizedData('name')
            ];
        }

        return $options;
    }
}
