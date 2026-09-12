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

  systemd.user.services.protondrive = {
    Unit = {
      Description = "Proton Drive (rclone)";
      After = [ "network-online.target" ];
    };
    Service = {
      RuntimeDirectory = "rclone";
      ExecStartPre = "${pkgs.coreutils}/bin/install -m600 /run/secrets/rclone.conf %t/rclone/rclone.conf";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount protondrive: %h/ProtonDrive \
          --config %t/rclone/rclone.conf \
          --vfs-cache-mode full
      '';
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u %h/ProtonDrive";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
