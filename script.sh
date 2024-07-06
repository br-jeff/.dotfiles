# install ZSH, .oh-my.zsh powerlevel

cp ./zsh/home/DOT-oh-my-zsh/* -r ~.oh-my-zsh
cp ./zsh/home/DOT-zsh/* -r ~.zsh
cp .zsh/home/powerlevel10k/* -r ~/powerlevel10k/

#install alacritty
cp ./alacritty/* -r ~/.config/alacritty/

sudo pacman -S fzf xdg-desktop-portal pamixer pavucontrol pipewire xdg-desktop-portal xdg-desktop-portal-wlr swappy slurp

# install hyperland
cp ./hyperland/cfg/* -r ~/.config/hypr/

#instal waybar
cp ./waybar/* -r ~/.config/waybar/
