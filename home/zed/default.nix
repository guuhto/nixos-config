{ ... }:
let
  theme = import ./theme.nix;
  keymap = import ./keymap.nix;
  tasks = import ./tasks.nix;
in
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ] ++ theme.extensions;
    userSettings = {
      icon_theme = "JetBrains New UI Icons (Dark)";
      vim_mode = true;
      project_panel.dock = "left";
      outline_panel.dock = "left";
      collaboration_panel.dock = "left";
      git_panel.dock = "left";
      agent = {
        dock = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = theme.theme;
      format_on_save = "on";
      formatter = "auto";
      toolbar.breadcrumbs = true;
      edit_predictions.provider = "zed";
      languages = {
        Nix = {
          language_servers = [ "nil" ];
          formatter.external = {
            command = "nixpkgs-fmt";
            arguments = [ ];
          };
        };
        Rust = {
          language_servers = [ "rust-analyzer" ];
          formatter = "language_server";
        };
        Python = {
          language_servers = [ "pyright" ];
          formatter = "language_server";
        };
        Go = {
          language_servers = [ "gopls" ];
          formatter = "language_server";
        };
        C = {
          language_servers = [ "clangd" ];
          formatter = "language_server";
        };
      };
      lsp = {
        rust-analyzer.initialization_options.check.command = "clippy";
        nil.initialization_options.nix.flake.autoArchive = true;
      };
      autosave = "on_focus_change";
    };

    userKeymaps = keymap;
    userTasks = tasks;
  };
}
