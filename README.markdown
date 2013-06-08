dotfiles
========


Installing
----------

`git clone git://github.com/nojhan/liquidprompt.git ~/.liquidprompt && git clone git://github.com/WyseNynja/dotfiles.git ~/.dotfiles && ~/.dotfiles/install && . ~/.bashrc`

Updating External Libs
----------------------

```lang=bash
git subtree pull --prefix src/libs/vim-pathogen git://github.com/tpope/vim-pathogen.git master --squash
git subtree pull --prefix src/vim/bundles/vim-sensible git://github.com/tpope/vim-sensible.git master --squash
git subtree pull --prefix src/vim/bundles/vim-sleuth git://github.com/tpope/vim-sleuth.git master --squash
git subtree pull --prefix src/vim/bundles/vim-fugitive git://github.com/tpope/vim-fugitive.git master --squash
git subtree pull --prefix src/vim/bundles/vim-markdown git://github.com/plasticboy/vim-markdown.git master --squash
```
