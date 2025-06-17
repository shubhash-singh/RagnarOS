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

        # Add more pip packages here
      ]))

    jdk #java
    flutter #platform independent android IDE
    #    clang #c and c++
    #    mongodb
    cmake
    jdt-language-server # for auto complete in java
  ];
}
