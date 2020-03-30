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
        file=${file%.md}

        cat $SRC/boiler/doctype >>$OUT/$file.html
        cat $SRC/boiler/head    >>$OUT/$file.html

        # use first line of .md file as page title
        read -r title <$SRC/$file.md
        title=${title##*#}
        printf '<title>%s</title>\n' "$title" >>$OUT/$file.html

        >>$OUT/$file.html printf \
            '%s</head>\n<body>%s</body>\n<footer>%s</footer>\n</html>\n'  \
            "$(md2html $SRC/boiler/header.md)" \
            "$(md2html $SRC/$file.md)" \
            "$(md2html $SRC/boiler/footer.md)"
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
