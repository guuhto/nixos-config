{ pkgs, lib, ... }:
{
  home.activation.rustupDefault = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x "${pkgs.rustup}/bin/rustup" ]; then
      $DRY_RUN_CMD ${pkgs.rustup}/bin/rustup default stable
    fi
  '';
}
