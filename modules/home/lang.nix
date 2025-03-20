{pkgs, ...}: {
  home.packages = with pkgs; [
    python313 # python 3.13
    zulu23 # java 23

    # pip files
    python312Packages.django
    python312Packages.pandas
    python312Packages.numpy
    python312Packages.pymongo
  ];
}
