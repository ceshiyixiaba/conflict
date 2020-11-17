echo "# 合并冲突测试"   > README.md
echo ""                >> README.md

commit() {
  git add -A; git commit -m "$1";
}

co_init() {
  git checkout -b "$1_init" master;
}

co_our() {
  git checkout -b "$1_our" master;
}

co_their() {
  git checkout -b "$1_their" master;
}

octc="our create, their create."
co_our   "octc"; echo "$octc our"   > octc.txt; commit "$octc our"
co_their "octc"; echo "$octc their" > octc.txt; commit "$octr their"

octr="our create, their rename."
co_init  "octr"; echo "$octr init" > octr.init.txt; commit "$octr init"
co_our   "octr"; echo "$octr our"  > octr.txt;      commit "$octr our"
co_their "octr"; mv octr.init.txt octr.txt;         commit "$octr their"

outu="our update, their update.";
co_init  "outu"; echo "$outu init"  > outu.init.txt; commit "$outu init"
co_our   "outu"; echo "$outu our"   > outu.init.txt; commit "$outu our"
co_their "outu"; echo "$outu their" > outu.init.txt; commit "$outu their"

outr="our update, their rename.";
co_init  "outr"; echo "$outr init" > outr.init.txt
co_our   "outr"; echo "$outr our"  > outr.init.txt
co_their "outr"; mv outr.init.txt outr.their.init

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

git add -A
git commit -m "Initial commit"

# init





git add -A; git commit -m "init commit"

# our

git checkout -b our master





git add -A; git commit -m "out commit"

# their

git checkout -b their master





git add -A; git commit -m "their commit"
