{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.terminal.programs.k8s-cli;
in {
  imports = [
    inputs.krewfile.homeManagerModules.krewfile
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Kubectl. Plugins are managed down below using krewfile.
      kubectl

      # helm
      (wrapHelm kubernetes-helm {
        plugins = with kubernetes-helmPlugins; [
          helm-secrets
          helm-s3
        ];
      })

      # Misc tools
      kubecolor
      k9s
      kdash

      # OS specific tools
      talosctl
   ];

   programs = {
     krewfile = {
      enable = true;
      krewPackage = pkgs.krew;
      plugins = [
        "allctx"
        "cost"
        "ctr"
        "ctx"
        "df-pv"
        "explore"
        "krew"
        "ktop"
        "neat"
        "ns"
        "tree"
        "stern"
        "view-allocations"
        "view-cert"
        "view-secret"
        "view-utilization"
      ];
     };

     zsh = mkIf config.terminal.shell.zsh.enable {
       # Making kubectl completions work even if kubecolor is used.
       initExtra = "source <(kubectl completion zsh | sed 's/kubectl/kubecolor/g')";

       shellAliases = {
         kubectl = "kubecolor";
         kk = "kubectl krew";
         kns = "kubectl ns";
         kcon = "kubectl ctx";
       };

       oh-my-zsh = {
         plugins = [
           "kubectl"
         ];
       };
     };
    };
  };
}
