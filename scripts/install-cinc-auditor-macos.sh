#!/bin/sh
set -ex
hdiutil attach $(find data -name '*.dmg')
sudo installer -package "$(find "/Volumes/Cinc Auditor/" -name '*.pkg')" -target /
hdiutil detach "/Volumes/Cinc Auditor/"
