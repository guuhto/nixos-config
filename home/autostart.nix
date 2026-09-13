{ pkgs, ... }:
{
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
      StartLimitBurst = 3;
      StartLimitIntervalSec = 300;
    };
    Service = {
      RuntimeDirectory = "rclone";
      ExecStartPre = "${pkgs.coreutils}/bin/install -m600 /run/secrets/rclone.conf %t/rclone/rclone.conf";
       ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount protondrive: %h/ProtonDrive \
          --config %t/rclone/rclone.conf \
          --vfs-cache-mode full \
          --low-level-retries 1 \
          --retries 1
      '';
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u %h/ProtonDrive";
      Restart = "on-failure";
      RestartSec = 30;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
