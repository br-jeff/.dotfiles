# install ZSH, .oh-my.zsh powerlevel install TPM


# ~;.local/share/fonts  Bitstream && Source Foundry
sudo apt install stow flameshot fzf 
sudo apt install openjdk-17-jdk
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
