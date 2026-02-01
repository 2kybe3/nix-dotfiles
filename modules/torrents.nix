{ config, pkgs, ... }:
let
  domain = config.kybe.lib.caddy.domain;
  address = "transmission.${domain}";
  createCaddyProxy = config.kybe.lib.caddy.createCaddyProxy;
in
{
  # services = {
  #   transmission = {
  #     enable = true;
  #     openPeerPorts = true;
  #
  #     settings = {
  #       download-dir = "/home/kybe/transmission/download";
  #       incomplete-dir = "/home/kybe/transmission/incomplete";
  #       rpc-bind-address = "127.0.0.1";
  #       rpc-url = "/transmission/";
  #       rpc-host-whitelist-enabled = true;
  #       rpc-host-whitelist = address;
  #
  #       peer-port = 39894;
  #
  #       script-torrent-done-enabled = true;
  #       script-torrent-done-filename = pkgs.writeText "extract.sh" ''
  #         #!/bin/bash
  #         find /$TR_TORRENT_DIR/$TR_TORRENT_NAME -name "*.rar" -execdir ${pkgs.unrar}/bin/unrar e -o- "{}" \;
  #       '';
  #     };
  #   };
  # };
}
