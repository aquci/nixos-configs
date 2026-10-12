{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    bat
    cava
    chromium
    cmake
    curl
    discord
    distrobox
    docker
    eza
    fastfetch
    gcc
    git
    gnumake
    grim
    htop
    iptables
    jq
    keepassxc
    kitty
    krita
    lavat
    localsend
    nano
    nemo
    neovim
    obsidian
    obs-studio
    pavucontrol
    rofi
    slurp
    starship
    telegram-desktop
    tor-browser
    udisks2
    unzip
    usbutils
    vial
    wbg
    waybar
    wget
    wl-clipboard
    xrandr
    zoxide

      (prismlauncher.override {
    gamemodeSupport = true;
    controllerSupport = true;

    additionalPrograms = [
      ffmpeg
      gamemode
    ];

    jdks = [
      jdk25
      jdk21
      jdk17
    ];
  })
  ];
}
