#!/bin/sh -ex

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
HOST=wvr
REMOTE_DIR=/var/www/html
SRC=./src
OUT=./www/html
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

md2html() {
    discount -b $REMOTE_DIR \
        -f smarty,fencedcode,toc,tabstop,footnote,image,links "$1"
}

init() {
    rm -r $OUT 2>/dev/null ||:
    mkdir -p $OUT
}

build() {
    cat $SRC/boiler/doctype >>$OUT/index.html
    cat $SRC/boiler/header >>$OUT/index.html

    md2html $SRC/index.md >>$OUT/index.html

    cp -r $SRC/res $OUT/
}

copy() {
    rsync -rvhtuc --progress --delete $OUT/ $HOST:$REMOTE_DIR
}

main() {
    init
    build
    copy
}

main
