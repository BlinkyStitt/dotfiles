dotfiles
========

Much thanks to...

- josephwecker for [bashrc_dispatch](https://github.com/josephwecker/bashrc_dispatch)
- nojhan for [liquidprompt](https://github.com/nojhan/liquidprompt)
- plasticboy for [vim-markdown](https://github.com/plasticboy/vim-markdown)
- tpope for [vim-pathogen](https://github.com/tpope/vim-pathogen) and other vim plugins


Installing
----------

`git clone git://github.com/nojhan/liquidprompt.git ~/.liquidprompt && git clone git://github.com/WyseNynja/dotfiles.git ~/.dotfiles && ~/.dotfiles/install && . ~/.bashrc`


Updating External Libs
----------------------

```lang=bash
git subtree pull --prefix src/libs/vim-pathogen git://github.com/tpope/vim-pathogen.git master --squash
git subtree pull --prefix src/vim/bundle/vim-sensible git://github.com/tpope/vim-sensible.git master --squash
git subtree pull --prefix src/vim/bundle/vim-sleuth git://github.com/tpope/vim-sleuth.git master --squash
git subtree pull --prefix src/vim/bundle/vim-fugitive git://github.com/tpope/vim-fugitive.git master --squash
git subtree pull --prefix src/vim/bundle/vim-markdown git://github.com/plasticboy/vim-markdown.git master --squash
```
