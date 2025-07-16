{
  # Enable ClamAV antivirus daemon and updater
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Restrict who can use the Nix package manager
  nix.settings.allowed-users = [ "root" ];

  boot.kernel.sysctl = {
    # Prevent unprivileged users from accessing or modifying named pipes (FIFOs)
    "fs.protected_fifos" = 2;
    # Prevent unprivileged users from modifying regular files via procfs
    "fs.protected_regular" = 2;
    # Disable core dumps for setuid binaries to avoid leaking sensitive information
    "fs.suid_dumpable" = false;
    # Restrict access to kernel pointer addresses to mitigate kernel info leaks
    "kernel.kptr_restrict" = 2;
    # Disable SysRq key to prevent unauthorized system control
    "kernel.sysrq" = false;
    # Disable unprivileged BPF to prevent potential security exploits
    "kernel.unprivileged_bpf_disabled" = true;

    # Enable strict hardening for BPF JIT compilation to reduce attack surface
    "net.core.bpf_jit_harden" = 2;

    # Disable ICMP redirect acceptance to prevent MITM attacks
    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.default.accept_redirects" = false;

    # Enable logging of packets from suspicious sources (martians)
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.default.log_martians" = true;

    # Enable strict reverse path filtering to prevent IP spoofing
    "net.ipv4.conf.all.rp_filter" = true;
    # Disable ICMP redirect sending to avoid network misconfiguration risks
    "net.ipv4.conf.all.send_redirects" = false;
  };

  # Secure /proc by hiding process details from non-owners
  fileSystems."/proc" = {
    device = "proc";
    fsType = "proc";
    options = [ "defaults" "hidepid=2" ];
    # This might not be necessary, but it ensures /proc is mounted early
    neededForBoot = true;
  };

  # Blacklist unused or potentially risky kernel modules
  boot.blacklistedKernelModules = [ "dccp" "sctp" "rds" "tipc" ];

  # Use dbus-broker for better security and performance over traditional dbus
  services.dbus.implementation = "broker";

  # Restrict sudo usage to users in the 'wheel' group
  security.sudo.execWheelOnly = true;

  # Harden systemd-rfkill service to prevent unauthorized access to RF devices
  systemd.services.systemd-rfkill = {
    serviceConfig = {
      ProtectSystem = "strict"; # Restrict write access to system directories
      ProtectHome = true; # Deny access to home directories
      ProtectKernelTunables = true; # Prevent modification of kernel tunables
      ProtectKernelModules = true; # Block module loading/unloading
      ProtectControlGroups = true; # Restrict access to cgroup hierarchy
      ProtectClock = true; # Block modifications to system time
      ProtectProc = "invisible"; # Hide process details from non-owners
      ProcSubset = "pid"; # Restrict /proc exposure
      PrivateTmp = true; # Isolate temporary files
      MemoryDenyWriteExecute =
        true; # Prevent memory regions from being both writable and executable
      NoNewPrivileges =
        true; # Ensure service and children cannot gain privileges
      LockPersonality = true; # Prevent changes to process execution domain
      RestrictRealtime = true; # Block real-time scheduling privileges
      SystemCallArchitectures =
        "native"; # Restrict system calls to the native architecture
      UMask = "0077"; # Default file permissions: owner-only access
      IPAddressDeny = "any"; # Block network access for this service
    };
  };

  # Harden systemd-journald service for logging security
  systemd.services.systemd-journald = {
    serviceConfig = {
      UMask = 77; # Restrict log file permissions (owner-only access)
      PrivateNetwork = true; # Isolate journald from the network
      ProtectHostname = true; # Prevent changes to the system hostname
      ProtectKernelModules = true; # Prevent kernel module tampering
    };
  };
}
