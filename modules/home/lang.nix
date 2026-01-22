{pkgs, ...}: {
  home.packages = with pkgs; [
    # pip files

    (python311.withPackages (ps:
      with ps; [
        markdown2
        numpy
        pandas
        django
        matplotlib
        openpyxl
        sympy
        seaborn
        virtualenv
      ]))

    jdk #java
    mysql84 # MySQL
    mongodb-ce # MongoDB 
    cmake
    nodejs_24
    jdt-language-server # for auto complete in java
    maven # maven to build java project
    apktool # apk reverse engineering
    jadx # apk reverse engineering
    xclicker # auto clicker
    autotrace # png to svg converter
  ];
}
