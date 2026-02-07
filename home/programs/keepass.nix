{config, ...}: {
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      General.LastActiveDatabase = "${config.home.homeDirectory}/syncthing/keepass/vault.kdbx";
      SSHAgent.Enabled = true;

      Browser = {
        Enabled = true;
        UpdateBinaryPath = false;
      };

      Security = {
        LockDatabaseIdle = false;
        IconDownloadFallback = true;
      };

      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePasswords = true;
      };
    };
  };

  wayland.windowManager.sway.config.startup = [
    {command = "cat ${config.sops.secrets.keepass.path} | keepassxc --pw-stdin ~/syncthing/keepass/vault.kdbx";}
  ];
}
