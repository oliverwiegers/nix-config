{pkgs, ...}: {
  home = {
    packages = with pkgs.unstable; [
      urlview
    ];

    file = {
      ".urlview" = {
        target = ".urlview";
        text = ''
          COMMAND firefox --new-tab %s
        '';
      };
    };
  };
}
