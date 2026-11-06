{ pkgs, ... }:
{
  home.packages = with pkgs; [
    catppuccin-cursors.mochaMauve
  ];

  programs.plasma = {
    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kcminputrc"."Keyboard"."NumLock" = 0;
      "kdeglobals"."General"."accentColorFromWallpaper" = false;
      "kdeglobals"."KDE"."widgetStyle" = "Breeze";
      "kdeglobals"."Sounds"."Enable" = false;
      "kwinrc"."MouseBindings"."CommandActiveTitlebar2" = "Minimize";
      "kwinrc"."MouseBindings"."CommandInactiveTitlebar2" = "Minimize";
      "kwinrc"."Plugins"."magiclampEnabled" = true;
      "kwinrc"."Plugins"."shakecursorEnabled" = false;
      "kwinrc"."Plugins"."slideEnabled" = false;
      "kwinrc"."Plugins"."squashEnabled" = false;
    };
    enable = true;
    kwin = {
      titlebarButtons.left = [ "close" "minimize" "maximize" ];
      titlebarButtons.right = [ "keep-above-windows" "on-all-desktops" ];
      virtualDesktops = { number = 1; rows = 1; };
    };
    overrideConfig = false;
    workspace = {
      colorScheme = "CatppuccinMochaMauve";
      cursor.theme = "catppuccin-mocha-mauve-cursors";
      iconTheme = "Relax-Light-Icons";
      theme = "Sweet";
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Sweet-Dark-transparent";
      };
    };
  };
}
