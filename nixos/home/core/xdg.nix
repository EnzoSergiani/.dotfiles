{ config, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      setSessionVariables = true;
      createDirectories = true;
      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = null;
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = null;
      templates = null;
      videos = "${config.home.homeDirectory}/videos";
      projects = null;
    };
  };

  home.activation.createCustomDirectories = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
      ${config.home.homeDirectory}/backup \
      ${config.home.homeDirectory}/dev/projects \
      ${config.home.homeDirectory}/dev/vm
  '';
}
