{pkgs, ...}: {
  environment.systemPackages = with pkgs; [eza bat zoxide lazygit];
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      histSize = 10000;

      shellAliases = {
        vim = "nvim";
        vi = "nvim";
        v = "nvim";
        c = "clear";
        clera = "clear";
        celar = "clear";
        e = "exit";
        cd = "z";
        ls = "eza --icons=always --no-quotes";
        tree = "eza --icons=always --tree --no-quotes";
        sl = "ls";

        # git
        g = "lazygit";
        ga = "git add";
        gc = "git commit";
        gcu = "git add . && git commit -m 'Update'";
        gp = "git push";
        gpl = "git pull";
        gs = "git status";
        gd = "git diff";
        gco = "git checkout";
        gcb = "git checkout -b";
        gbr = "git branch";
        grs = "git reset HEAD~1";
        grh = "git reset --hard HEAD~1";

        gaa = "git add .";
        gcm = "git commit -m";
      };
    };
    starship.enable = true;
  };
}
