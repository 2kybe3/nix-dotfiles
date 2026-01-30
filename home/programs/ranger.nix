{
  programs.ranger = {
    enable = true;
    plugins = [
      {
        name = "zoxide";
        src = fetchGit {
          url = "https://github.com/jchook/ranger-zoxide.git";
          rev = "363df97af34c96ea873c5b13b035413f56b12ead";
        };
      }
    ];
    extraConfig = ''
      set preview_images true
      set preview_images_method kitty
    '';
  };
}
