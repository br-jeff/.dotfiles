# install ZSH, .oh-my.zsh powerlevel

cp ./zsh/home/DOT-oh-my-zsh/* ~.oh-my-zsh
cp ./zsh/home/DOT-zsh/* ~.zsh
cp .zsh/home/powerlevel10k/* ~/powerlevel10k/

#install alacritty
cp ./alacritty/* ~/.config/alacritty/

sudo pacman -S fzf xdg-desktop-portal pamixer pavucontrol pipewire xdg-desktop-portal xdg-desktop-portal-wlr swappy slurp

# install hyperland
cp ./hyperland/* ~/.config/hypr/
