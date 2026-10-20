{ pkgs, ... }:
{
  systemd.user.services.agentcraft = {
    Unit.Description = "AgentCraft Foreman";

    Service = {
      WorkingDirectory = "%h/agentcraft/foreman";
      ExecStart = "${pkgs.nodejs_22}/bin/npm run start -- --backend claude --use-claude-login --repo %h/projetos/webhook-dispatcher --model sonnet --workers juniper,kit --user-name Gustavo";
      Environment = [
        "PATH=${pkgs.lib.makeBinPath [ pkgs.nodejs_22 pkgs.git pkgs.go pkgs.coreutils pkgs.bash ]}:/etc/profiles/per-user/gustavo/bin:/run/current-system/sw/bin"
      ];
      KillSignal = "SIGINT";
      TimeoutStopSec = 30;
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
