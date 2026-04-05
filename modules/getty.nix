{ lib, ... }:
{
  services.getty = {
    autologinOnce = true;
    autologinUser = "kybe";
    helpLine = lib.mkForce "";
    extraArgs = [
      "--nohostname"
    ];
  };
}
