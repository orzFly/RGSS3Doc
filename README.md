RGSS3Doc
========

Building on your own
--------------------
```bash
git clone https://github.com/orzFly/RGSS3Doc.git
cd RGSS3Doc
gem install sdoc
origin=`pwd`
pushd /path/to/your/gems/sdoc-0.3.20
patch -p1 < $origin/sdoc.patch
popd

rake
```
