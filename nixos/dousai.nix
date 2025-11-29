{ config, pkgs, ... }:

let
  dotfiles = "/home/dousai/.dotfiles";
  configDirs = builtins.attrNames (builtins.readDir "${dotfiles}/config");
in
{
  home.username = "dousai";
  home.homeDirectory = "/home/dousai";

  home.file = builtins.listToAttrs (map (name: {
    name = ".config/${name}";
    value.source = "${dotfiles}/config/${name}";
  }) configDirs);

  xdg = {
    enable = true;   
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };

  home.activation.createCustomDirectories = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
      ${config.home.homeDirectory}/dev/projects \
      ${config.home.homeDirectory}/dev/vm \
      ${config.home.homeDirectory}/latex
  '';

  home.packages = with pkgs; [
    btop
    cava
    discord
    fastfetch
    firefox
    hypridle
    hyprlock
    hyprpaper
    kitty
    lazygit
    lsd
    nautilus
    ncdu
    obsidian
    playerctl
    rofi
    signal-desktop
    swaynotificationcenter
    virtualbox
    waybar
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile "${dotfiles}/config/zsh/.zshrc";
  };

  programs.git = {
    enable = true;
    userName  = "EnzoSergiani";
    userEmail = "enzo.sergiani@protonmail.com";
  };

  programs.neovim.enable = true;
  
  programs.vscode = {
  enable = true;

  package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      aaron-bond.better-comments
      adpyke.codesnap
      akamud.vscode-theme-onelight
      burkeholland.simple-react-snippets
      cschlosser.doxdocgen
      davidanson.vscode-markdownlint
      donjayamanne.python-environment-manager
      dsznajder.es7-react-js-snippets
      dustypomerleau.rust-syntax
      ecmel.vscode-html-css
      formulahendry.auto-close-tag
      formulahendry.auto-rename-tag
      github.copilot
      github.copilot-chat
      github.vscode-github-actions
      github.vscode-pull-request-github
      james-yu.latex-workshop
      jasonnutter.search-node-modules
      jeff-hykin.better-cpp-syntax
      jock.svg
      mechatroner.rainbow-csv
      ms-ceintl.vscode-language-pack-fr
      ms-python.black-formatter
      ms-python.debugpy
      ms-python.isort
      ms-python.python
      ms-python.vscode-pylance
      ms-python.vscode-python-envs
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools-themes
      ms-vscode.makefile-tools
      ms-vscode.remote-repositories
      ms-vsliveshare.vsliveshare
      pkief.material-icon-theme
      ritwickdey.liveserver
      rust-lang.rust-analyzer
      rvest.vs-code-prettier-eslint
      streetsidesoftware.code-spell-checker
      streetsidesoftware.code-spell-checker-french
      tamasfe.even-better-toml
      twxs.cmake
      usernamehw.errorlens
      vadimcn.vscode-lldb
      vivaxy.vscode-conventional-commits
      xabikos.javascriptsnippets
      yongke.latex-wordcount
      yzane.markdown-pdf
      yzhang.markdown-all-in-one
      zhuangtongfa.material-theme
    ];
  };

  home.stateVersion = "25.05";
}

