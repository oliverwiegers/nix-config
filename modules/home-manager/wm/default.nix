{lib, ...}:
with lib; {
  imports = [
    ./hyprland
    ./yabai
  ];

  options = {
    wm = {
      hyprland = {
        enable = mkEnableOption "Enable Hyprland.";
      };

      yabai = {
        enable = mkEnableOption "Enable Yabai (MacOS).";
      };
    };
  };
}
