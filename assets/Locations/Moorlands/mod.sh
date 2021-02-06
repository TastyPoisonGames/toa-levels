#/bin/sh

for f in $(find `pwd` -name '*.png'); do
  magick convert $f -modulate 120,100,90 $f
done

