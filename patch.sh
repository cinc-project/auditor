#!/bin/sh -e

cd inspec
git reset --hard
git clean -f -d
cd ..

# patching executable names
cd inspec/bin
rename 's/inspec/outspec/' *
cd ../..
sed -i '/spec.executables   =/ s/inspec/outspec/g' inspec/inspec.gemspec

# apply all other patches
# 1. find all patches in the patch directory
# 2. using the path of patch determine the source file/dir path
# 3. build the target file/dir path by replacing inspec with outspec in the source path
# 4. copy the source file/dir to the target file/dir
# 5. apply the patch
for p in $(cd patch && find . -type f -name "*.patch" && cd ..); do
  dir="inspec/$(dirname $p)"
  src_name=$(basename -s .patch $p)
  tgt_name=$(echo $src_name | sed 's/inspec/outspec/g')
  cdir=$(pwd)
  patch="$cdir/patch/$p"

  cd $dir
  cp -r $src_name $tgt_name

  if [ -d $tgt_name ]; then
    cd $tgt_name
    patch < $patch
  else
    patch $tgt_name $patch
  fi

  cd $cdir
done

# copy additional files
cp -rp files/* inspec/
