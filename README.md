```
ln -s init.vim ~/.config/nvim/init.vim
ln -s c-header.txt ~/.config/nvim/c-header.txt
```

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

```
pip3 install --user neovim psutil setproctitle
```

For tmux I reduce the escape time to something small, otherwise a double ESC is required to enter normal mode.

```
set escape-time 10
```
