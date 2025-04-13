{pkgs, ...}: {
  programs.vscode = {
    userSettings = {
      "chat.editor.fontFamily" = "JetBrains Mono";
      "chat.editor.fontSize" = 19.0;
      "debug.console.fontFamily" = "JetBrains Mono";
      "debug.console.fontSize" = 20.0;
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontSize" = 19.0;
      "editor.inlayHints.fontFamily" = "JetBrains Mono";
      "editor.inlineSuggest.fontFamily" = "JetBrains Mono";
      "editor.minimap.sectionHeaderFontSize" = 12.857142857142858;
      "markdown.preview.fontFamily" = "Montserrat";
      "markdown.preview.fontSize" = 20.0;
      "scm.inputFontFamily" = "JetBrains Mono";
      "scm.inputFontSize" = 18.571428571428573;
      "screencastMode.fontSize" = 80.0;
      "terminal.integrated.fontSize" = 19.0;
      "workbench.colorTheme" = "Houston";
      "files.autoSave" = "onFocusChange";
      "git.autofetch" = true;
    };

    enable = false;
    package = pkgs.vscode-fhs;
    # extensions = with pkgs.vscode-extensions; [
    # ];
  };

  home.packages = with pkgs; [
    python3
    jdk
    wkhtmltopdf
    # python pip packages
    python312Packages.django
    python312Packages.pandas
    python312Packages.numpy
    python312Packages.pymongo
    python312Packages.markdown2
    python312Packages.pdfkit
    #python312Packages.opencv3
  ];
}
