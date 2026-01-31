{ config, ... }:
{
  sops.secrets.syncthing.sopsFile = ../../secrets/syncthing.yaml;
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8383";
    passwordFile = config.sops.secrets.syncthing.path;
    overrideDevices = true;
    settings = {
      gui = {
        theme = "black";
        user = "kybe";
      };
      minHomeDiskFree = {
        unit = "%";
        value = 2;
      };
      devices = {
        "kybe.xyz" = {
          id = "X2TZ44D-O26DTNM-WRPIFJP-M75HMBQ-3WH4KLQ-COS7E3P-FE2MJAR-WU2N6AH";
          introducer = true;
        };
        phone = {
          id = "P366B4T-SOUZTBV-G4G5IE2-7MXQ4DQ-DFKXKKM-WVBJMSZ-Q7ZPOAN-32MUFAY";
          introducer = true;
        };
      };
      folders = {
        "/home/kybe/syncthing/phone/Documents" = {
          id = "nbrf9-2w4wy";
          devices = [
            "kybe.xyz"
            "phone"
          ];
        };
        "/home/kybe/syncthing/phone/pictures" = {
          id = "labpe-fxw3q";
          devices = [
            "kybe.xyz"
            "phone"
          ];
        };
        "/home/kybe/syncthing/phone/dcim" = {
          id = "d7tbq-371tj";
          devices = [
            "kybe.xyz"
            "phone"
          ];
        };
        "/home/kybe/syncthing/phone/aesis" = {
          id = "c2vbp-mdgxw";
          devices = [
            "kybe.xyz"
            "phone"
          ];
        };
      };
    };
  };
}
