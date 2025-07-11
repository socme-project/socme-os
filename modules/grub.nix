{ pkgs, ... }: {
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages =
      pkgs.linuxPackages_zen; # _zen, _hardened, _rt, _rt_latest, etc.
  };
}
