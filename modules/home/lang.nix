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

        # Add more pip packages here
      ]))

    jdk #java
    flutter #platform independent android IDE
    mysql84 # MySQL
    mongodb-ce # MongoDB 
    cmake
    nodejs_24
    jdt-language-server # for auto complete in java
  ];
}
