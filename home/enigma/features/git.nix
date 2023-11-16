{...}: {
  programs = {
    git = {
      enable = true;
      extraConfig = {
        user = {
          email = "oliver.wiegers@gmail.com";
          name = "oliverwiegers";
          signingkey = "244D3FF3276A942F8666536FDE9FDB17F778EFDA";
        };
        commit = {
          gpgsign = true;
        };
        gpg = {
          program = "gpg2";
        };
        init = {
          defaultBranch = "main";
        };
        "protocoll \"http\"" = {
          allow = "never";
        };
        "protocoll \"git\"" = {
          allow = "never";
        };
      };
    };
  };
}
