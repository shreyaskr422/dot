# ASUS Arch Linux Package List

A collection of essential packages for an ASUS ROG/TUF setup featuring the Zen kernel, Hybrid Graphics, and Hyprland.

### Installation

```bash
yay -S \
  linux-zen linux-zen-headers linux-lts linux-lts-headers linux-firmware \
  nvidia-open-dkms nvidia-prime nvidia-utils nvidia-settings libva-nvidia-driver \
  xf86-video-amdgpu amd-ucode xf86-input-libinput \
  asusctl asusctltray-git supergfxctl rog-control-center \
  hyprland xdg-desktop-portal-hyprland waybar swaync wlogout rofi-wayland swww \
  brightnessctl easyeffects networkmanager network-manager-applet os-prober \
  wezterm-git zsh-theme-powerlevel10k-git zsh-autosuggestions zsh-syntax-highlighting \
  eza nwg-look btop code mpv vim neovim ungoogled-chromium-bin \
  ttf-iosevka-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji
```

### Reference
For detailed configuration, visit the [Asus-Linux Arch Guide](https://asus-linux.org/guides/arch-guide/).
