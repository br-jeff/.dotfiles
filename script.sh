# install ZSH, .oh-my.zsh powerlevel install TPM

sudo apt-get install zsh

# ~;.local/share/fonts Bitstream && Source Foundry
sudo apt install stow flameshot fzf 

curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo apt update
sudo apt install i3

zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

stow 
# Below are default versions on .zshrc
asdf install nodejs 14.21.3
asdf install java adoptopenjdk-17.0.0+35
asdf install golang 1.20.2
asdf global maven 3.5.4

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latestt
