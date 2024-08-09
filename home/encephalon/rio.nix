{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.rio = {
    enable = true;
    package = inputs.rio.packages.x86_64-linux.default;
    settings = {
      editor = "hx";
      cursor = "█";
      blinking-cursor = true;
      fonts = {
        family = "Maple Mono NF";
      };
    };
  };
}
