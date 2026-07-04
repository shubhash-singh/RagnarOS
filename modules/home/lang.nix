{pkgs, ...}: {
  home.packages = with pkgs; [
    # pip files

    (python313.withPackages (ps:
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
    wkhtmltopdf
    jdk #java
    mysql84 # MySQL
    mongodb-ce # MongoDB 
    xclicker # auto clicker
  ];
}
