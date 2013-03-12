#!/bin/sh

lastrefhash=""
mainrepo="chriskempson/tomorrow-theme"

while true; do
  if [ ! -d ./tmp ]; then
    git clone "git://github.com/$mainrepo.git" ./tmp
  fi


  cd ./tmp
  git pull --ff-only
  refhash="`git log -1 | head -1 | sed -e 's/^commit //'`"
  cd -

  if [ "$lastrefhash" != "$refhash" ]; then
    lastrefhash=refhash
    cp -r ./tmp/vim/* ./
    git add .
    git commit -a -m "Auto-update to $mainrepo @$refhash"
    git push
  fi

  sleep $((60 * 5))
done
