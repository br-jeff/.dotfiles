# install ZSH, .oh-my.zsh powerlevel install TPM


# ~;.local/share/fonts  Bitstream && Source Foundry
sudo apt install stow flameshot fzf 


# Below are default versions on .zshrc
asdf install nodejs 14.21.3
asdf install java adoptopenjdk-17.0.0+35
asdf install golang 1.20.2
asdf global maven 3.5.4

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
