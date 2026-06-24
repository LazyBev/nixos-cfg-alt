{ config, pkgs, ... }: {
  users.users.medusa = {
    isNormalUser = true;
    description = "medusa";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.fish;
    hashedPassword = "$6$H/Cm8YT56j2aFZrF$jO/4WoieGtU4zhkz6VfRcfZDElLHLJnRuGe54LfFaN3rvRj2L4ZuaktZDdQqVkwMYd8R1En5Ha7wk9ShBBM8U1";
  };
  users.defaultUserShell = pkgs.fish;
}
