{
  services.openssh = {
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
}
