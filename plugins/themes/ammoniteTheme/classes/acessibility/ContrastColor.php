<?php

/**
 * @file plugins/themes/ammoniteTheme/classes/acessibility/ContrastColor.php
 *
 * Copyright (c) 2026 Simon Fraser University
 * Copyright (c) 2026 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class ContrastColor
 * @ingroup plugins_themes_ammonite
 *
 * @brief Contrast color manager
 */

namespace APP\plugins\themes\ammoniteTheme\classes\acessibility;

class ContrastColor {

    /**
     * Retrieves the contrast color for a given background color
     */
    public static function getContrastColor(string $backgroundColor): array
    {
        $bgColor = self::parseColor($backgroundColor);
        $blackContrast = self::calculateContrast([0, 0, 0], $bgColor);
        $whiteContrast = self::calculateContrast([255, 255, 255], $bgColor);

        $color = $whiteContrast > $blackContrast ? '#FFFFFF' : '#000000';
        $contrastRatio = number_format(max($whiteContrast, $blackContrast), 2) . ':1';

        return [
            'color' => $color,
            'contrastRatio' => $contrastRatio
        ];
    }

    /**
     * Parses a color string into an array of RGB values
     */
    public static function parseColor(string $color): array
    {
        if (strpos($color, '#') === 0) {
            $color = substr($color, 1);
            return [
                hexdec(substr($color, 0, 2)),
                hexdec(substr($color, 2, 2)),
                hexdec(substr($color, 4, 2))
            ];
        }
        return array_map('intval', preg_split('/\D+/', $color, -1, PREG_SPLIT_NO_EMPTY));
    }

    /**
    * Calculates the contrast ratio between two RGB colors
    */
    public static function calculateContrast(array $rgb1, array $rgb2): float
    {
        $l1 = self::getLuminance($rgb1);
        $l2 = self::getLuminance($rgb2);
        return (max($l1, $l2) + 0.05) / (min($l1, $l2) + 0.05);
    }

    /**
     * Calculates the luminance of an RGB color
     */
    public static function getLuminance(array $rgb): float
    {
        $a = array_map(function ($v) {
            $v /= 255;
            return $v <= 0.03928 ? $v / 12.92 : pow(($v + 0.055) / 1.055, 2.4);
        }, $rgb);
        return $a[0] * 0.2126 + $a[1] * 0.7152 + $a[2] * 0.0722;
    }
}
