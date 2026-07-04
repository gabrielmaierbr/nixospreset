# modules/terminal.nix
#
# Configuração declarativa do terminal: Kitty + Fish + Fastfetch
# + utilitários modernos de CLI (fzf, zoxide, eza, bat, starship)
# + integração de cores dinâmicas com o Noctalia
#
# Import no home.nix:
#   imports = [ ./modules/terminal.nix ];
#
# Para adicionar/remover uma ferramenta, mexa só no bloco correspondente
# abaixo — cada seção é independente das outras.
#
# IMPORTANTE SOBRE CORES DO NOCTALIA:
# Para Kitty e Starship seguirem a paleta do Noctalia automaticamente,
# você precisa ativar os templates correspondentes DENTRO do Noctalia:
#   Configurações do Noctalia > Color Schemes > Templates > marcar
#   "Kitty" e "Starship" como ativos.
# Isso faz o Noctalia escrever/atualizar os arquivos de cor sempre que
# você trocar de wallpaper ou esquema de cores — sem precisar de rebuild.

{ config, pkgs, ... }:
{
  # ============================================================
  # FASTFETCH — exibido ao abrir um terminal novo
  # ============================================================
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        color = "blue"; # troque para "auto" se quiser seguir cores do terminal
        separator = "  ";
      };
      logo = {
        source = "nixos";
        padding = {
          left = 2;
          top = 1;
        };
      };
      modules = [
        # linhas em branco no início = "margin-top" dos módulos
        # (adicione ou remova blocos destes para ajustar o espaçamento)
        { type = "custom"; format = ""; }
        { type = "custom"; format = ""; }
        { type = "custom"; format = ""; }
        { type = "custom"; format = ""; }

        { type = "title"; }
        { type = "separator"; }
        { type = "os"; key = "  OS"; }
        { type = "host"; key = "  Host"; }
        { type = "kernel"; key = "  Kernel"; }
        { type = "packages"; key = "  Pacotes"; }
        { type = "wm"; key = "  WM"; }
        { type = "cpu"; key = "  CPU"; }
        { type = "gpu"; key = "  GPU"; }
        { type = "memory"; key = "  Memória"; }
        { type = "break"; }
        { type = "colors"; symbol = "circle"; }
      ];
    };
  };

  # ============================================================
  # FISH — shell principal (autocomplete e syntax highlight nativos)
  # ============================================================
  programs.fish = {
    enable = true;

    # "plugins" no estilo Fisher, mas gerenciados 100% pelo Nix
    # (adicione/remova itens da lista para mudar plugins)
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "puffer";   src = pkgs.fishPlugins.puffer.src; }
    ];

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      cat    = "bat";
      ls     = "eza --icons --group-directories-first";
      ll     = "eza --icons --group-directories-first -la";
      lt     = "eza --icons --tree";
    };

    interactiveShellInit = ''
      set fish_greeting            # remove a saudação padrão do fish
      starship init fish | source  # inicializa o starship manualmente
      fastfetch
    '';
  };

  # ============================================================
  # ZOXIDE — "cd" inteligente (uso: z nome-da-pasta)
  # ============================================================
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # ============================================================
  # FZF — fuzzy finder (Ctrl+R no histórico, Ctrl+T em arquivos)
  # ============================================================
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # ============================================================
  # EZA — substituto moderno do "ls" (ícones, árvore, cores)
  # ============================================================
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  # ============================================================
  # BAT — substituto moderno do "cat" (syntax highlight)
  # ============================================================
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };

  # ============================================================
  # STARSHIP — prompt (git branch, linguagem do projeto, etc)
  # ============================================================
  # O starship.toml precisa ser editável pelo Noctalia (ele injeta as
  # cores dentro de [palettes.noctalia] sempre que você troca de
  # wallpaper/paleta). Por isso NÃO usamos "programs.starship.enable"
  # completo — o Home Manager trava o arquivo como symlink somente-
  # leitura pro Nix store, o que impediria o Noctalia de escrever nele.
  #
  # Em vez disso, usamos home.activation: esse hook roda a cada
  # rebuild, mas só CRIA o arquivo se ele ainda não existir. Depois da
  # primeira vez, o Nix nunca mais toca nesse arquivo — quem passa a
  # "tomar conta" dele é o Noctalia (para a seção de cores) e você
  # manualmente (para o resto, tipo format/character).
  home.activation.criarStarshipToml = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    STARSHIP_TOML="$HOME/.config/starship.toml"
    if [ ! -f "$STARSHIP_TOML" ]; then
      mkdir -p "$HOME/.config"
      cat > "$STARSHIP_TOML" << 'EOF'
palette = "noctalia"
add_newline = true
format = "$all"

[character]
error_symbol = "[➜](bold red)"
success_symbol = "[➜](bold green)"
[palettes.noctalia]
EOF
    fi
  '';

  # ============================================================
  # KITTY — terminal emulator (com animações nativas)
  # ============================================================
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      # --- animações / efeitos nativos do Kitty ---
      cursor_trail = "1";
      cursor_trail_decay = "0.1 0.4";
      cursor_blink_interval = "0.5";

      # --- comportamento ---
      enable_audio_bell = "no";
      window_alert_on_bell = "yes";
      confirm_os_window_close = "0";

      # --- aparência ---
      background_opacity = "0.92";
      window_padding_width = "6";
    };

    # Inclui o arquivo de cores gerado dinamicamente pelo Noctalia.
    # Esse arquivo muda sozinho sempre que você troca de wallpaper/paleta
    # no Noctalia, sem precisar de rebuild do Nix.
    extraConfig = ''
      include themes/noctalia.conf
    '';

    shellIntegration.enableFishIntegration = true;
  };

  # ============================================================
  # PACOTES — starship (config gerenciada pelo Noctalia, ver acima)
  # e fonte Nerd Font (necessária para ícones no eza/starship/fastfetch)
  # ============================================================
  home.packages = with pkgs; [
    starship
    nerd-fonts.jetbrains-mono
  ];
}
