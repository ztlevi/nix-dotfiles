{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.fzf;
in {
  options.modules.shell.fzf = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ fzf ];
    home.configFile = {
      "fzf" = {
        source = "${configDir}/fzf";
        recursive = true;
      };
    };
    env.FZF_BASE = "${pkgs.fzf}/share/fzf";
    modules.shell.zsh.rcFiles =
      [ "${configDir}/fzf/aliases.zsh" "${configDir}/fzf/env.zsh" ];
  };
}
