# https://github.com/hrkfdn/ncspot/issues/1757#issuecomment-3709315765
# (unused but still keeping for future reference)

final: prev: {
  ncspot = prev.ncspot.overrideAttrs (oldAttrs: rec {
    src = prev.fetchFromGitHub {
      owner = "cyqsimon";
      repo = "ncspot";
      rev = "82a07e840d5ca2721e928e0db3c4700c397ac208";
      hash = "sha256-rtNTzxX7ttRQE3xuBTFHfiumX7ROIb4X289DFsaHEAY=";
    };

    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-NbpDh9vIXowhvJrWN7kU96Wra+o7+xtjwvheWo1B5NE=";
    };
  });
}
