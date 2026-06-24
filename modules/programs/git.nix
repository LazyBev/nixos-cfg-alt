{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user.name = "medusa";
      user.email = "medusa@ari.lt";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      safe.directory = [
        "/home/medusa/nixos-cfg"
        "/home/medusa/nixos-cfg-alt"
      ];
    };
  };
}
