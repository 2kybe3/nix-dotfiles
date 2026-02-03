{ config, ... }:
{
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      General.LastActiveDatabase = "${config.home.homeDirectory}/syncthing/keepass/vault.kdbx";
      Browser.UpdateBinaryPath = false;

      GUI = {
        AdvancedSettings = true;
        ApplicationTheme = "dark";
        CompactMode = true;
        HidePasswords = true;
      };

      SSHAgent.Enabled = true;
    };
  };
}
