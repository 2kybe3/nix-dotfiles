{ config, ... }:
let
  domain = config.kybe.lib.domain;
  createCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;

  knxDevice = "knx";
  serverDevice = "server";
  phoneDevice = "phone";

  allDevices = [
    knxDevice
    serverDevice
    phoneDevice
  ];

  syncthingUser = if config.networking.hostName == "server" then "root" else "kybe";
  folderDir =
    if config.networking.hostName == "server" then
      "/root/syncthing"
    else
      "/home/${syncthingUser}/syncthing";
  dataDir = folderDir;
in
{
  sops.secrets = {
    syncthingPass = {
      sopsFile = ../secrets/syncthing.yaml;
      owner = config.services.syncthing.user;
    };
    syncthingKey = {
      sopsFile = ../secrets/${config.networking.hostName}-syncthing-key.pem;
      format = "binary";
    };
    syncthingCert = {
      sopsFile = ../secrets/${config.networking.hostName}-syncthing-cert.pem;
      format = "binary";
    };
  };

  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    user = syncthingUser;
    dataDir = dataDir;
    guiAddress = "127.0.0.1:8384";
    guiPasswordFile = config.sops.secrets.syncthingPass.path;
    cert = config.sops.secrets.syncthingCert.path;
    key = config.sops.secrets.syncthingKey.path;

    settings = {
      gui = {
        user = "kybe";
        insecureAdminAccess = false;
        insecureSkipHostcheck = true;
        theme = "black";
      };
      options = {
        urAccepted = -1;
        localAccounceEnabled = false;
        relaysEnabled = true;
      };
      devices = {
        ${serverDevice} = {
          id = "X2TZ44D-O26DTNM-WRPIFJP-M75HMBQ-3WH4KLQ-COS7E3P-FE2MJAR-WU2N6AH";
          introducer = true;
        };
        ${knxDevice} = {
          id = "PPZGUI7-QHAZ6O7-CGCOVXB-BWZ5LEN-Y5CEGES-TMJDILA-SKQLDPK-I4CDUAN";
        };
        ${phoneDevice} = {
          id = "P366B4T-SOUZTBV-G4G5IE2-7MXQ4DQ-DFKXKKM-WVBJMSZ-Q7ZPOAN-32MUFAY";
        };
      };
      folders = {
        "phone/documents" = {
          id = "nbrf9-2w4wy";
          devices = allDevices;
          path = "${folderDir}/phone/Documents";
        };
        "pictures" = {
          id = "labpe-fxw3q";
          devices = allDevices;
          path = "${folderDir}/phone/pictures";
        };
        "phone/dcim" = {
          id = "d7tbq-371tj";
          devices = allDevices;
          path = "${folderDir}/phone/dcim";
        };
        "phone/aesis" = {
          id = "c2vbp-mdgxw";
          devices = allDevices;
          path = "${folderDir}/phone/aesis";
        };
      };
    };
  };

  services.caddy.virtualHosts."syncthing.${domain}" = createCaddyProxy "8384";
}
