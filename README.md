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
  ttf-iosevka-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji slurp grim \
```




# My Arch Linux Setup – ASUS ROG Laptop (Hybrid NVIDIA)

Clean Arch install with Hyprland, NVIDIA hybrid graphics, ROG tools, and power profiles tuned for different scenarios.

## Core GPU & Power Tools (already in your system)

- **nvidia-open-dkms** + **nvidia-utils** + **nvidia-prime** → open kernel modules + prime-run
- **asusctl** + **supergfxctl** + **rog-control-center** → fan curves, power profiles, GPU switching
- **power-profiles-daemon** → balanced / power-saver modes
- **supergfxd** service → must be enabled (`systemctl enable --now supergfxd`)
- **asusd** service → usually enabled with asusctl

Your current GPU modes (from supergfxctl):
- Integrated → only iGPU (best battery)
- Hybrid → iGPU default + NVIDIA on-demand via `prime-run` (recommended daily)
- Compute / VFIO → not needed for you

**Warning (2025–2026 reality):** supergfxctl is being phased out slowly. For most ROG laptops hybrid + prime-run still works fine.

## Recommended GPU + Power Profiles (best meta for you)

### 1. AC Power (Home / Learning / Normal use)
- Mode: **Hybrid**
- Power profile: **performance** or **balanced**
- Run heavy apps with: `prime-run firefox` / `prime-run code` / `prime-run steam`
- Why: good perf when plugged in, still uses iGPU for desktop to save a bit of power

### 2. Battery – Normal Use (browsing, coding, light tasks)
- Mode: **Hybrid**
- Power profile: **balanced** or **power-saver**
- **Never** use `prime-run` unless really needed
- Why: NVIDIA stays suspended most time → longest reasonable battery life

### 3. Battery – Maximum Life (College / Travel / Lectures)
- Mode: **Integrated** (only iGPU)
- Power profile: **power-saver**
- Silent / Quiet fan mode via asusctl
- Charge limit: `asusctl -c 80` or `asusctl -c 60` (recommended)
- Why: lowest power draw, longest battery, coolest & quietest

### 4. Heavy Work (OBS, video edit, GPU tasks, gaming)
- Mode: **Hybrid**
- Power profile: **performance**
- Launch with: `prime-run obs` / `prime-run blender` / `prime-run vkcube`
- Optional: switch to MUX discrete (NVIDIA only) via ROG Control Center or `asusctl graphics -m discrete` — but requires logout/reboot and kills battery fast

## Quick Commands You Use Often

```bash
# Check current GPU mode
supergfxctl -g

# Switch modes (reboot usually needed)
supergfxctl -m hybrid
supergfxctl -m integrated

# Set power profile
powerprofilesctl set performance    # or balanced / power-saver

# ROG fan & power
asusctl profile -P Performance      # or Balanced / Quiet
asusctl fan-curve -m Quiet -f cpu -e true
asusctl -c 80                       # battery charge limit 80%

# Check NVIDIA status
nvidia-smi                          # should show when prime-run is used
prime-run glxinfo | grep "OpenGL renderer"



paru -S --needed nvidia-open-dkms nvidia-utils nvidia-prime lib32-nvidia-utils nvidia-settings asusctl supergfxctl rog-control-center power-profiles-daemon 


after that

systemctl enable --now supergfxd asusd power-profiles-daemon


# NVIDIA suspend/resume fix (run ONCE - fixes black screen/wake issues on ROG hybrid)
sudo systemctl enable --now nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service
sudo mkdir -p /etc/modprobe.d
echo 'options nvidia NVreg_PreserveVideoMemoryAllocations=1' | sudo tee /etc/modprobe.d/nvidia-power-management.conf
sudo mkinitcpio -P
reboot

### Reference
For detailed configuration, visit the [Asus-Linux Arch Guide](https://asus-linux.org/guides/arch-guide/).
