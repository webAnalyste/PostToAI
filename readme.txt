=== ShareToAI ===
Contributors: franckscan
Tags: ai, chatgpt, claude, perplexity, summary
Requires at least: 5.0
Tested up to: 6.9
Requires PHP: 7.4
Stable tag: 1.1.0
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Automatically add links to AI services (Perplexity, ChatGPT, Claude, Grok, Mistral) to summarize your posts and Custom Post Types.

== Description ==

ShareToAI automatically displays a customizable invitation "Summarize this content with:" followed by clickable icons to various AI services (Perplexity, ChatGPT, Claude, Grok, Mistral).

= Key Features =

* **Automatic display** on posts and custom post types
* **5 AI services** supported: Perplexity, ChatGPT, Claude, Grok, Mistral
* **3 display styles**: icons only, buttons with text, or list
* **Shortcode** `[sharetoai]` for manual placement
* **Fully customizable** text and AI prompt
* **Position control**: top, bottom, both, or manual via shortcode
* **Custom Post Types** support
* **Responsive** and accessible design
* **Secure** following WordPress standards
* **SEO-friendly** with rel="nofollow" on external links

= How It Works =

1. Install and activate the plugin
2. Go to Settings > ShareToAI
3. Choose which AI services to display
4. Customize the text and prompt
5. Select display style and position
6. Your posts now have AI summary links!

= Use Cases =

* Allow readers to get AI summaries of your articles
* Provide quick content overview via AI
* Enhance user experience with AI tools
* Share your content with AI assistants

= Shortcode Usage =

Use `[sharetoai]` anywhere in your content to manually place the AI links.

== Installation ==

= Automatic Installation =

1. Go to Plugins > Add New
2. Search for "ShareToAI"
3. Click "Install Now"
4. Activate the plugin
5. Go to Settings > ShareToAI to configure

= Manual Installation =

1. Download the plugin ZIP file
2. Go to Plugins > Add New > Upload Plugin
3. Choose the ZIP file and click "Install Now"
4. Activate the plugin
5. Go to Settings > ShareToAI to configure

= Configuration =

After activation:

1. Go to **Settings > ShareToAI**
2. **Enable/Disable** the plugin
3. **Select AI services** to display (Perplexity, ChatGPT, Claude, Grok, Mistral)
4. **Choose display style**: Icons, Buttons, or List
5. **Set position**: Top of content, Bottom, Both, or Manual (shortcode only)
6. **Customize text**: Default is "Summarize this content with:"
7. **Customize prompt**: Use {URL} placeholder for the page URL
8. **Select post types**: Posts, Pages, or Custom Post Types
9. Click **Save Changes**

== Frequently Asked Questions ==

= Which AI services are supported? =

Currently supported: Perplexity, ChatGPT, Claude, Grok, and Mistral. More services may be added in future updates.

= Can I customize the AI prompt? =

Yes! Go to Settings > ShareToAI and edit the "Custom Prompt" field. Use {URL} as a placeholder for the current page URL.

= Does this work with Custom Post Types? =

Yes! You can select which post types should display the AI links in the settings.

= Can I place the links manually? =

Yes! Use the `[sharetoai]` shortcode anywhere in your content. Set the position to "Manual" in settings to disable automatic display.

= Are the AI links SEO-friendly? =

Yes! All external AI links include rel="nofollow noopener noreferrer" attributes to protect your SEO.

= Does this plugin send data to external services? =

No! The plugin only creates links. When users click on them, they are redirected to the AI service with the page URL. No data is sent from your server.

= Is it compatible with page builders? =

Yes! The plugin works with any theme or page builder. You can also use the shortcode in page builders.

= Can I change the appearance? =

Yes! Choose from 3 built-in styles (Icons, Buttons, List) or add custom CSS to match your theme.

== Screenshots ==

1. Plugin settings page in Settings > ShareToAI
2. AI links displayed with "Icons" style on a post
3. Display with "Buttons with text" style
4. Display with "List" style
5. Custom prompt configuration with {URL} placeholder

== Changelog ==

= 1.1.0 - 2026-03-03 =
* Optimized for WordPress.org
* Removed custom update system (WordPress.org handles updates natively)
* Removed load_plugin_textdomain() (automatic since WP 4.6)
* Updated compatibility to WordPress 6.9

= 1.0.3 - 2026-03-03 =
* Test version for automatic update system

= 1.0.2 - 2026-03-03 =
* Updated author information: Franck Scandolera / webAnalyste
* Fixed default prompt

= 1.0.1 - 2026-03-03 =
* Added rel="nofollow" to all AI links (SEO)
* Fixed button style (removed text underline)
* Visual improvement with borders on buttons

= 1.0.0 - 2026-03-03 =
* Initial release
* Automatic display and shortcode
* 5 AI services supported (Perplexity, ChatGPT, Claude, Grok, Mistral)
* 3 display styles (icons, buttons, list)
* Complete admin interface
* Custom text and prompt
* Custom Post Types support
* Responsive and accessible
* Secure following WordPress standards

== Upgrade Notice ==

= 1.1.0 =
WordPress.org optimized version. WordPress will now handle updates automatically.

= 1.0.0 =
Initial release of ShareToAI plugin.

== Support ==

For questions or issues:
* GitHub: https://github.com/webAnalyste/shareToAI/issues
* Website: https://www.webanalyste.com

== Development ==

Source code available on GitHub: https://github.com/webAnalyste/shareToAI

Contributions welcome!
