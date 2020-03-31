#!/usr/bin/env dash

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
HOST=wvr
REMOTE_DIR=/var/www/html
SRC=./src
OUT=./www/html
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

md2html() {
    discount -f autolink,smarty,fencedcode,toc,tabstop,footnote,\
image,links,superscript,strikethrough "$1"
}

init() {
    rm -r $OUT 2>/dev/null
    mkdir -p $OUT
    cp -r $SRC/res $OUT/
}

build() {
    find $SRC -type f -name '*.md' | \
    while read -r file ; do
        file=${file#$SRC/}
        mkdir -p $OUT/${file%/*}
        file=${file%.md}
        {
            cat $SRC/head.html
            printf '<title>%s</title>\n</head>' ${file%/*}
            printf '<header><p>%s</p></header>\n' "$(md2html $SRC/header.md)"
            printf '<body>%s</body>\n' "$(md2html $SRC/$file.md)"
            printf '<footer><p>%s</p></footer>\n</html>\n' "$(md2html $SRC/footer.md)"
        } >>$OUT/$file.html &
    done
    wait
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
