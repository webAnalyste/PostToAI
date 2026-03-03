<?php
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

delete_option('aisl_options');

delete_site_option('aisl_options');
