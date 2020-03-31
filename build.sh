#!/bin/sh -e

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
HOST=wvr
REMOTE_DIR=/var/www/html
SRC=./src
OUT=./www/html
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

md2html() {
    discount -f smarty,fencedcode,toc,tabstop,footnote,image,links "$1"
}

init() {
    rm -r $OUT 2>/dev/null ||:
    mkdir -p $OUT
    cp -r $SRC/res $OUT/
}

build() {
    find $SRC -type f -name *.md ! -path *boiler* | \
    while read -r file ; do
        file=${file#$SRC/}
        mkdir -p $OUT/${file%/*}
        file=${file%.md}
        {
            cat $SRC/boiler/doctype
            cat $SRC/boiler/head

            # use first line of .md file as page title
            printf '<title>%s</title>\n</head>' ${file%/*}

            printf '<header><p>%s</p></header>\n' "$(md2html $SRC/boiler/header.md)"
            printf '<body>%s</body>\n' "$(md2html $SRC/$file.md)"
            printf '<footer><p>%s</p></footer>\n' "$(md2html $SRC/boiler/footer.md)"

            # close
            echo '</html>\n'
        } >>$OUT/$file.html
    done
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
