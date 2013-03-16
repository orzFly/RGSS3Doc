RGSSDoc
=======

```sh
gem install sdoc
origin=`pwd`
pushd /path/to/your/gems/sdoc-0.3.20
patch -p1 < $origin/sdoc.patch
popd

rake
```
