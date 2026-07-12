{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "guuhto";
      user.email = "gustavocorsino50@gmail.com";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
