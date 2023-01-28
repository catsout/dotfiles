{ config, pkgs, ... }:
let 
 ts_parsers = pkgs.tree-sitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "out";
  home.homeDirectory = "/var/home/out";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    flutter
    nodejs
    screen
    cmake-language-server
    nil
    tree-sitter
    neovim
    hugo
    clash
    neofetch
    nmap
    strace
    go
    tokei
    unrar
    meson
    rust-analyzer
    patchelf
    crunch

    poetry
    
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" ];
    })
  ];

  xdg.configFile."nvim/nix/parser".source = "${ts_parsers}";
}
