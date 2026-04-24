{ pkgs, ... }:
{
  programs.iamb = {
    enable = true;
    package = pkgs.iamb.overrideAttrs (
      finalAttrs: previousAttrs: {
        patches = [
          ./iamb.patch
        ]
        ++ previousAttrs.patches;
      }
    );
    settings = {
      settings = {
        notifications.enable = true;
        image_preview.size = {
          height = 10;
          width = 66;
        };
      };
      profiles."kybe.xyz" = {
        user_id = "@kybe:kybe.xyz";
        layout.style = "restore";
      };
    };
  };
}
