{...}: {
  programs.niri = {
    enable = true;
    withUWSM = true;
  };

  security.pam.services.gtklock = {};
}
