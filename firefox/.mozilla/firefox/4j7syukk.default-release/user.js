// Firefox user preferences

// Set start page
user_pref("browser.startup.homepage", "about:blank");

// Disable new tab page
user_pref("browser.newtabpage.enabled", false);

// Disable loading the clipboard URL on middle click
user_pref("middlemouse.contentLoadURL", false);

// Don't play media until it is in the foreground
user_pref("media.block-autoplay-until-in-foreground", true);

// What to do upon starting a new session; 0: Blank page, 1: Homepage, 2: Last page visited, 3: Previous session
user_pref("browser.startup.page", 3);

// Allow @-moz-document domain() syntax in userContent.css
user_pref("layout.css.moz-document.content.enabled", true);

// Hide suggested search engines in the search bar dropdown
user_pref("browser.urlbar.oneOffSearches", false);

// Allow installation of unsigned addons/extensions
user_pref("xpinstall.signatures.required", false);

// Enabled browser console
user_pref("devtools.chrome.enabled", true);

// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable video auto-play
user_pref("media.autoplay.default", 0);

// Enable search suggestions in the address bar
user_pref("browser.search.suggest.enabled", true);

// Disable recommendations
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
