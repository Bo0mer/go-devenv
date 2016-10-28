#!/bin/bash
set -e -x

apt-get -y update
apt-get -y install vim-nox nano curl git wget unzip

wget -qO- https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz | tar -C /usr/local -xzf -

#Set up $GOPATH and add go executables to $PATH
cat > /etc/profile.d/go_env.sh <<\EOF
export GOPATH=/home/vagrant/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
EOF
chmod +x /etc/profile.d/go_env.sh

git clone https://github.com/Bo0mer/vim-go-ide.git /home/vagrant/.vim_go_runtime
sh /home/vagrant/.vim_go_runtime/bin/install

echo 'set runtimepath^=~/.vim_go_runtime
source ~/.vim_go_runtime/vimrc/basic.vim
source ~/.vim_go_runtime/vimrc/filetypes.vim
source ~/.vim_go_runtime/vimrc/plugins.vim
source ~/.vim_go_runtime/vimrc/extended.vim
try
source ~/.vim_go_runtime/custom_config.vim
catch
endtry' > /home/vagrant/.vimrc.go

cat > /etc/profile.d/go_vim.sh <<\EOF
alias govim='vim -u /home/vagrant/.vimrc.go'
EOF
chmod +x /etc/profile.d/go_vim.sh

