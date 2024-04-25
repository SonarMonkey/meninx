{
  config,
  pkgs,
  ...
}: {
  # Configure Starship
  programs.starship = {
    # Enable, but disable for bash
    enable = true;
    enableBashIntegration = false;

    # Configure
    settings = {
      add_newline = false;
      format = "╭─$username$hostname$directory$git_branch$fill$time─╮$line_break├─$fill─╯$line_break╰─$character";
      character = {
        format = "$symbol ";
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
      };
      username = {
        show_always = true;
        format = "[$user]($style) at ";
        disabled = false;
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style) in ";
        disabled = false;
      };
      directory = {
        format = "[$path ]($style)";
        truncation_length = 3;
        truncation_symbol = "../";
      };
      git_branch = {
        symbol = "";
        format = "[on $symbol $branch]($style)";
      };
      fill = {
        symbol = "─";
        style = "white";
      };
      time = {
        format = "[$time]($style)";
        time_format = "%D %r";
        disabled = false;
      };
    };
  };
}
