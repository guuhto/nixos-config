{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "modern" ];
    })
    catppuccin-cursors.mochaMauve
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = false;

    workspace = {
      lookAndFeel = "Catppuccin-Mocha-Mauve";
      colorScheme = "CatppuccinMochaMauve";
      iconTheme = "YAMIS";
      cursor.theme = "catppuccin-mocha-mauve-cursors";
      windowDecorations = {
        library = "org.kde.kwin.klassy";
        theme = "Klassy";
      };
    };

    kwin = {
      titlebarButtons.left = [ "close" "minimize" "maximize" ];
      titlebarButtons.right = [ "keep-above-windows" "on-all-desktops" ];
      virtualDesktops = { number = 1; rows = 1; };
    };

    configFile = {
      "kcminputrc"."Keyboard"."NumLock" = 0;
      "kdeglobals"."KDE"."widgetStyle" = "Breeze";
      "kdeglobals"."General"."accentColorFromWallpaper" = false;
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
