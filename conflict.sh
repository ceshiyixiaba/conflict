#!/bin/bash

# | our\their | create     | update        | rename                                      | delete          |
# | ---       | :---:      | :----:        | :---:                                       | :---:           |
# | create    | both added | -             | renamed                                     | -               |
# | update    | -          | both modified | renamed                                     | deleted by them |
# | rename    | both added | modified      | both deleted & added by us && added by them | added by us     |
# | delete    | -          | deleted by us | added by them                               | Y               |

git init conflict
cd conflict

# 初始化

echo "# 合并冲突测试"   > README.md
echo ""                >> README.md

git add -A
git commit -m "Initial commit"

co_init() {
  git checkout master
}

co_our() {
  git checkout our
}

co_their() {
  git checkout their
}

commit_init() {
  git commit -m "$1 init"
}

commit_our() {
  git commit -m "$1 our"
}

commit_their() {
  git commit -m "$1 their"
}

octc="our create, their create."
co_our;   echo "$octc our"   > octc.txt; commit_our   $octc
co_their; echo "$octc their" > octc.txt; commit_their $octc

octr="our create, their rename."
co_init;  echo "$octr init" > octr.init.txt; commit_init  $octr
co_our;   echo "$octr our" > octr.txt;       commit_our   $octr
co_their; mv octr.init.txt octr.their.txt;   commit_their $octr

outu="our update, their update."; echo $outu >> README.md
echo "$outu init" > outu.init.txt
echo "$outu our" > outu.init.txt
echo "$outu their" > outu.init.txt

outr="our update, their rename."; echo $outr >> README.md
echo "$outr init" > outr.init.txt
echo "$outr our" > outr.init.txt
mv outr.init.txt outr.their.init

outd="our update, their delete."; echo $outd >> README.md
echo "$outd init" > outd.init.txt
echo "$outd our" > outd.init.txt
rm outd.init.txt

ortc="our rename, their create."; echo $ortc >> README.md
echo "$ortc init" > ortc.init.txt
mv ortc.init.txt ortc.txt
echo "$ortc their" > ortc.txt

ortu="our rename, their update."; echo $ortu >> README.md
echo "$ortu init" > ortu.init.txt
mv ortu.init.txt ortu.our.txt
echo "$ortu their" > ortu.init.txt

ortr="our rename, their rename."; echo $ortr >> README.md
echo "$ortr init" > ortr.init.txt
mv ortr.init.txt ortr.our.txt
mv ortr.init.txt ortr.their.txt

ortd="our rename, their delete."; echo $ortd >> README.md
echo "$ortd init" > ortd.init.txt
mv ortd.init.txt ortd.our.txt
rm ortd.init.txt

odtu="our delete, their update."; echo $odtu >> README.md
echo "$odtu init" > odtu.init.txt
rm odtu.init.txt
echo "$odtu their" > odtu.init.txt

odtr="our delete, their rename."; echo $odtr >> README.md
echo "$odtr init" > odtr.init.txt
rm odtr.init.txt
mv odtr.init.txt odtr.their.txt

odtd="our delete, their delete."; echo $odtd >> README.md
echo "$odtd init" > odtd.init.txt
rm odtd.init.txt
rm odtd.init.txt

# init

git add -A; git commit -m "init commit"

# our

git checkout -b our master

git add -A; git commit -m "out commit"

# their

git checkout -b their master

git add -A; git commit -m "their commit"
