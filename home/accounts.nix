{
  self,
  config,
  ...
}: {
  sops.secrets."kybe.xyz".sopsFile = "${self}/secrets/mail.yaml";

  programs = {
    himalaya.enable = true;
    thunderbird = {
      enable = true;
      profiles."kybe".isDefault = true;
      settings = {
        "general.useragent.override" = ":-)";
        "extensions.autoDisableScopes" = 0; # automatically enable extensions
      };
    };
  };

  accounts.email.accounts."kybe@kybe.xyz" = {
    enable = true;
    primary = true;
    realName = "kybe";
    address = "kybe@kybe.xyz";
    userName = "kybe@kybe.xyz";
    imap = {
      host = "mail.kybe.xyz";
      port = 993;
      tls.enable = true;
    };
    smtp = {
      host = "mail.kybe.xyz";
      port = 465;
      tls.enable = true;
    };
    passwordCommand = "cat ${config.sops.secrets."kybe.xyz".path}";

    himalaya.enable = true;
    thunderbird.enable = true;
  };
}
