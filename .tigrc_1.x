# v1.x

set author-width = 14
set filename-width = 16
set id-width = 7
set blame-options = -C -C -C
set line-graphics = ascii
set line-number-interval = 1
set horizontal-scroll = 33%
set read-git-colors = yes
set show-author = abbreviated
set show-filename = always
set show-date = local
set show-notes = yes
set show-refs = yes
set show-id = yes
set show-rev-graph = yes
set show-changes = yes
set vertical-split = yes
set split-view-height = 70%
set status-untracked-dirs = yes
set tab-size = 2
set diff-context = 6
set ignore-space = some
set commit-order = topo
set ignore-case = no
set wrap-lines = no
set focus-child = yes
set show-line-numbers = yes

# rebase -i
bind main R !git rebase -i %(commit)
bind diff R !git rebase -i %(commit)