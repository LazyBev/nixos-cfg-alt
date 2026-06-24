{ lib, ... }: {
  options.vars = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "medusa";
      description = "Short name/alias";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "LazyBev";
      description = "Primary username";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "medusa@ari.lt";
      description = "Email address";
    };
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "yggdrasil";
      description = "System hostname";
    };
    theme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
      description = "Desktop theme name";
    };
    gtkTheme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
      description = "GTK theme name";
    };
    cursorTheme = lib.mkOption {
      type = lib.types.str;
      default = "catppuccin-mocha-mauve-cursors";
      description = "Cursor theme name";
    };
    cursorSize = lib.mkOption {
      type = lib.types.int;
      default = 24;
      description = "Cursor size";
    };
    iconTheme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
      description = "Icon theme name";
    };
    flakeDir = lib.mkOption {
      type = lib.types.str;
      default = "/home/medusa/nix";
      description = "Path to flake directory";
    };
    maxJobs = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Maximum Nix build jobs";
    };
  };
}
