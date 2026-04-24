{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ exiftool ];
  programs.yazi = {
    enable = true;
    shellWrapperName = "y"; # stateVersion
    settings = {
      mgr = {
        linemode = "permissions";
        show_hidden = true;
      };
      open.rules = [
        # Folder
        {
          url = "*/";
          use = [
            "edit"
            "reveal"
            "open"
          ];
        }
        # Markdown
        {
          url = "*.md";
          use = [
            "glow"
            "reveal"
            "edit"
            "open"
          ];
        }
        # Text
        {
          mime = "text/*";
          use = [
            "edit"
            "reveal"
            "open"
          ];
        }
        # Media
        {
          mime = "{audio,video}/*";
          use = [
            "play"
            "reveal"
            "open"
          ];
        }
        # Archive
        {
          mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
          use = [
            "extract"
            "reveal"
          ];
        }
        # Images
        {
          mime = "image/*";
          use = [
            "view"
            "reveal"
          ];
        }
        # Empty file
        {
          mime = "inode/empty";
          use = [ "view" ];
        }
        # Fallback
        {
          url = "*";
          use = [
            "edit"
            "open"
            "reveal"
          ];
        }
      ];
      opener = {
        play = [
          {
            run = "${lib.getExe pkgs.mpv} %s";
            desc = "Mpv";
            orphan = true;
            for = "unix";
          }
        ];
        glow = [
          {
            run = "${lib.getExe pkgs.glow} -t %s";
            desc = "Glow";
            block = true;
            for = "unix";
          }
        ];
        view = [
          {
            run = "${lib.getExe pkgs.imv} %s";
            desc = "Imv";
            orphan = true;
            for = "unix";
          }
        ];
        reveal = [
          {
            run = "clear;  exiftool %s1; read _";
            desc = "Show EXIF";
            for = "unix";
            block = true;
          }
        ];
        edit = [
          {
            run = "$EDITOR %s";
            desc = "Edit";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "${lib.getExe' pkgs.xdg-utils "xdg-open"} %s1";
            desc = "Open";
          }
        ];
      };
    };
    # https://github.com/sxyazi/yazi/blob/4e0acf8cbfcd66924af38a9418d3e12dc31a7316/yazi-config/preset/keymap-default.toml#L76
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "d";
          run = "remove --permanently";
          desc = "Permanently delete selected files";
        }
      ];
    };
  };
}
