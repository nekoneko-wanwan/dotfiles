# v2.x

# メインビューの表示設定
set main-view = id:yes date:true author:full commit-title:graph=yes,refs=yes

set id-width = 7
set blame-options = -C -C -C
set line-graphics = ascii
set horizontal-scroll = 33%
set show-notes = yes
set show-changes = yes
set vertical-split = yes
set split-view-width = 60%   # 垂直分割時の比率
set split-view-height = 60%
set status-untracked-dirs = yes
set tab-size = 2
set diff-context = 6
set ignore-space = some
set commit-order = topo
set ignore-case = no
set wrap-lines = no
set focus-child = yes

# rebase -i
bind main R !git rebase -i %(commit)
bind diff R !git rebase -i %(commit)

# -m branch: ブランチ名の変更（trigger -> M）
bind refs M !git branch -m %(branch) %(prompt)

# checkout {COMMIT_ID}: コミット名でcheckout（trigger -> C）
bind main C !git checkout %(commit)
