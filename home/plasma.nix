{ ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      widgetStyle = "Breeze";
    };

    kwin = {
      titlebarButtons.left = [ "close" "minimize" "maximize" ];
      titlebarButtons.right = [ "keep-above-windows" "on-all-desktops" ];
      virtualDesktops = {
        number = 1;
        rows = 1;
      };
    };

    configFile = {
      "kdeglobals"."KDE"."widgetStyle" = "Breeze";
      "kdeglobals"."General"."accentColorFromWallpaper" = true;
      "kdeglobals"."General"."ColorSchemeHash" = "f6df0e9f12a4783afd65d81532865d4d86848c5e";
      "kdeglobals"."Sounds"."Enable" = false;
      "kwinrc"."MouseBindings"."CommandActiveTitlebar2" = "Minimize";
      "kwinrc"."MouseBindings"."CommandInactiveTitlebar2" = "Minimize";
      "kwinrc"."Plugins"."magiclampEnabled" = true;
      "kwinrc"."Plugins"."shakecursorEnabled" = false;
      "kwinrc"."Plugins"."slideEnabled" = false;
      "kwinrc"."Plugins"."squashEnabled" = false;
    };
  };
}
