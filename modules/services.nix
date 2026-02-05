{lib, ...}: {
  services = {
    dbus.enable = true;
    printing.enable = true;
    mullvad-vpn.enable = true;
    gnome.gnome-keyring.enable = true;
    getty = {
      autologinOnce = true;
      autologinUser = "kybe";
      helpLine = lib.mkForce "";
    };
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = true;
        socksListenAddress = {
          IsolateDestAddr = true;
          addr = "127.0.0.1";
          port = 9050;
        };
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      ports = [
        22
      ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = ["kybe"];
        UseDns = true;
        PermitRootLogin = "no";
      };
    };
  };
}
