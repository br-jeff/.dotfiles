# Below are default versions on .zshrc
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin-add maven

asdf install nodejs 14.21.3
asdf install java adoptopenjdk-17.0.0+35
asdf install golang 1.20.2
asdf global maven 3.5.4
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latestth
