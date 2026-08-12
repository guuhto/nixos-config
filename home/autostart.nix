{ pkgs, ... }:
{
  systemd.user.services.megasync = {
    Unit = {
      Description = "MEGAsync";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Environment = [ "QT_QPA_PLATFORMTHEME=kde" "QT_STYLE_OVERRIDE=Breeze" ];
      ExecStart = "${pkgs.megasync}/bin/megasync";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.nextcloud = {
    Unit = {
      Description = "Nextcloud Desktop Client";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Environment = [ "QT_QPA_PLATFORMTHEME=kde" "QT_STYLE_OVERRIDE=Breeze" ];
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
