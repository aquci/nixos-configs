{config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ./home/modules/services.nix
    ./home/modules/packages.nix
    ./home/modules/programs.nix
    ./home/modules/user.nix
    ./home/modules/networking.nix
    ./home/modules/fonts.nix
    ./home/modules/nvidia.nix
    ./home/modules/experimental.nix
    ./home/modules/boot.nix
    ./home/modules/locale.nix
    ./happ-nixos/happ-module.nix
];

  virtualisation.podman = {
  enable = true;
  dockerCompat = true;
  };

  services.ollama = {
  enable = true;
  package = pkgs.ollama-cuda;
};
  services.flatpak.enable = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="0000", TAG+="uaccess", MODE="0660"
  '';

  security.sudo.wheelNeedsPassword = true;
  system.stateVersion = "26.05";
}
