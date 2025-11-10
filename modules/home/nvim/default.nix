{
  inputs, pkgs, ...
}: {
  home.packages = [
  inputs.nvim.packages.${pkgs.system}.default
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
