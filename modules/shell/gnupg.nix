{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.gnupg;
in {
  options.modules.shell.gnupg = with types; {
    enable = mkBoolOpt false;
    cacheTTL = mkOpt int 604800; # 1 week
  };

  config = mkIf cfg.enable {
    # environment.variables.GNUPGHOME = "$XDG_CONFIG_HOME/gnupg";

    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };

    user.packages = [ pkgs.tomb ];

    home.file."gnupg/gpg-agent.conf" = {
      text = ''
        default-cache-ttl ${toString cfg.cacheTTL}
      '';
    };
  };
}
