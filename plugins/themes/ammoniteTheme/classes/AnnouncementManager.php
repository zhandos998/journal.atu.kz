<?php

/**
 * @file plugins/themes/ammoniteTheme/classes/AnnouncementManager.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class AnnouncementManager
 * @ingroup plugins_themes_ammonite
 *
 * @brief Announcement manager
 */

namespace APP\plugins\themes\ammoniteTheme\classes;

use Illuminate\Database\Eloquent\Collection;
use PKP\announcement\Announcement;

class AnnouncementManager
{
    public static function getStaticAnnouncements(int $contextId): Collection
    {
        return Announcement::withContextIds([$contextId])
            ->withActiveByDate()
            ->orderBy('date_posted', 'desc')
            ->get();
    }
}
