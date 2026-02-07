{
  self,
  config,
  ...
}: {
  sops.secrets = {
    "kybe.xyz".sopsFile = "${self}/secrets/mail.yaml";
  };

  programs.himalaya.enable = true;

  accounts.email.accounts = {
    "kybe@kybe.xyz" = {
      enable = true;
      primary = true;
      realName = "kybe";
      address = "kybe@kybe.xyz";
      userName = "kybe@kybe.xyz";
      himalaya.enable = true;
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
    };
  };
}
