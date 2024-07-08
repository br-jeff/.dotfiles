# install ZSH, .oh-my.zsh powerlevel install TPM

cp ./zsh/home/DOT-oh-my-zsh/* -r ~.oh-my-zsh
cp ./zsh/home/DOT-zsh/* -r ~.zsh
cp .zsh/home/powerlevel10k/* -r ~/powerlevel10k/

#install alacritty
cp ./alacritty/* -r ~/.config/alacritty/

sudo pacman -S fzf xdg-desktop-portal pamixer pavucontrol pipewire xdg-desktop-portal xdg-desktop-portal-wlr swappy slurp wl-clipboard sof-firmware  socat cliphist hyprpicker nm-connection-editor dictd blueman bluez bluez-utils

yay -S hyprpicker waybar-cava bluez bluez-utils nwg-look thunar imv yazi eww


# install hyperland
cp ./hyperland/cfg/* -r ~/.config/hypr/

#instal waybar
cp ./waybar/* -r ~/.config/waybar/

cp ./rofi/* -r ~/.config/rofi/
