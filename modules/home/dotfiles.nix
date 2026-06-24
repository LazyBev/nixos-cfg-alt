{ pkgs, ... }: {
  hjem.users.medusa.files = {
    ".config/niri/config.kdl".source = ../../configs/niri/config.kdl;
    ".config/ribbon/config.rib".source = ../../configs/ribbon/config.rib;


    ".config/alacritty/alacritty.toml".source = ../../configs/alacritty/alacritty.toml;
    ".config/dunst/dunstrc".source = ../../configs/dunst/dunstrc;
    ".config/fuzzel/fuzzel.ini".source = ../../configs/fuzzel/fuzzel.ini;
    ".config/fcitx5/config".source = ../../configs/fcitx5/config;
    ".config/fcitx5/profile".source = ../../configs/fcitx5/profile;
    ".config/fcitx5/conf/chttrans.conf".source = ../../configs/fcitx5/conf/chttrans.conf;
    ".config/fcitx5/conf/keyboard.conf".source = ../../configs/fcitx5/conf/keyboard.conf;
    ".config/fcitx5/conf/notifications.conf".source = ../../configs/fcitx5/conf/notifications.conf;
    ".config/fcitx5/conf/punctuation.conf".source = ../../configs/fcitx5/conf/punctuation.conf;
    ".config/fcitx5/conf/spell.conf".source = ../../configs/fcitx5/conf/spell.conf;
    ".config/librewolf/librewolf/rlubfwj2.default/chrome/userChrome.css".source = ../../configs/librewolf/userChrome.css;
    ".config/librewolf/sidebery-sidebar.css".source = ../../configs/librewolf/sidebery-sidebar.css;
    ".config/librewolf/librewolf/rlubfwj2.default/user.js".source = ../../configs/librewolf/user.js;
    ".config/vesktop/settings.json".source = ../../configs/vesktop/vencord-settings.json;

    ".config/bat/config".text = "--theme=ansi";
    ".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Dracula
      gtk-icon-theme-name=Dracula
      gtk-cursor-theme-name=catppuccin-mocha-mauve-cursors
      gtk-cursor-theme-size=24
      gtk-application-prefer-dark-theme=1
    '';
    ".config/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Dracula
      gtk-icon-theme-name=Dracula
      gtk-cursor-theme-name=catppuccin-mocha-mauve-cursors
      gtk-cursor-theme-size=24
      gtk-application-prefer-dark-theme=1
    '';
    ".config/fetch/config".text = ''
      os
      host
      kernel
      uptime
      packages
      shell
      wm
      theme
      icons
      font
      cpu
      gpu
      memory
      swap
      disk
      ip
      battery
      colors
      label_color=magenta
      separator=─
      spin=xy
      speed=1.0
    '';
    ".config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Dracula
    '';
    ".config/dunst/icons".source = ../../configs/dunst/icons;

    "Pictures/agnes.png".source = ../../configs/Pictures/agnes.png;
    "Pictures/todo.png".source = ../../configs/Pictures/todo.png;

    ".config/librewolf/librewolf/profiles.ini".text = ''
      [Profile0]
      Name=default
      IsRelative=1
      Path=rlubfwj2.default
      Default=1

      [General]
      StartWithLastProfile=1
      Version=2
    '';

  };
}
