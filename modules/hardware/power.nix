{ config, lib, ... }: let
  inherit (lib) types mkOption mkIf;
  cfg = config.yggdrasil.powerProfiles;
in {
  options.yggdrasil.powerProfiles.default = mkOption {
    type = types.nullOr (types.enum [ "performance" "balanced" "power-saver" ]);
    default = "balanced";
    description = "Default power profile";
  };

  config = mkIf (cfg.default != null) {
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor =
      if cfg.default == "performance" then "performance"
      else if cfg.default == "power-saver" then "powersave"
      else "powersave";
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
}
