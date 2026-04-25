<?php
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

delete_option('fscan_ptai_options');

delete_site_option('fscan_ptai_options');
