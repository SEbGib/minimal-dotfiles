// Zen Browser Transparency Configuration
// This file sets up transparency preferences for Zen Browser

// Enable transparent browser tabs
user_pref("browser.tabs.allow_transparent_browser", true);

// Enable custom theme colors (required for transparency theme)
user_pref("zen.theme.gradient.show-custom-colors", true);

// Linux-specific transparency setting
{{- if eq .chezmoi.os "linux" }}
user_pref("zen.widget.linux.transparency", true);
{{- end }}

// Optional: Enable for better visual effects
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);