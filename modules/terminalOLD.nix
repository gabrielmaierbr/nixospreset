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
      logo = {
        source = "nixos";
        padding = {
          top = 1;
          left = 2;
        };
      };
      display = {
        separator = "  ";
        color = "blue"; # troque para "auto" se quiser seguir cores do terminal
      };
      modules = [
        { type = "title"; }
        { type = "separator"; }
        { type = "os"; key = "  OS"; }
        { type = "host"; key = "  Host"; }
        { type = "kernel"; key = "  Kernel"; }
        { type = "uptime"; key = "  Uptime"; }
        { type = "packages"; key = "  Pacotes"; }
        { type = "shell"; key = "  Shell"; }
        { type = "wm"; key = "  WM"; }
        { type = "terminal"; key = "  Terminal"; }
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
  # O starship.toml é gerenciado pelo Noctalia (ver nota no topo do
  # arquivo), que precisa ESCREVER nesse arquivo sempre que você troca
  # de paleta/wallpaper. Por isso não usamos "programs.starship.enable"
  # completo aqui — o Home Manager trava o arquivo como somente-leitura
  # (symlink pro Nix store), o que quebraria a escrita do Noctalia.
  # Em vez disso, só instalamos o binário e inicializamos manualmente
  # no Fish (feito acima, em interactiveShellInit).

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
