#!/usr/bin/env dash

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
HOST=wvr
REMOTE_DIR=/var/www/html
SRC=./src
OUT=./www/html
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

md2html() {
    discount -f autolink,smarty,fencedcode,toc,tabstop,\
footnote,image,links,superscript,strikethrough,\
definitionlist,dldiscount,dlextra "$*"
}

init() {
    rm -r $OUT 2>/dev/null
    mkdir -p $OUT
    cp -r $SRC/res $OUT/
}

add() {
    tag=$1
    shift
    printf "<$tag>\n%s\n</$tag>\n" "$*"
}

build() {
    find $SRC -type f -name '*.md' | \
    while read -r file ; do
        # trim the src dir from filename
        file=${file#$SRC/}
        # make diretory path if needed
        mkdir -p $OUT/${file%/*}
        # remove .md file extension
        file=${file%.md}

        # index files need to keep their .html extension to function.
        # other files can be linked without extension for ease of use
        # (and to keep vimwiki able to link within itself)
        [ ${file##*/} = index ] && ext=.html

        {
            # add the metadata information
            cat $SRC/head.html

            # use filename as page title
            printf '<title>%s</title>\n</head>' ${file%/*}

            add header "$(md2html $SRC/header.md)"
            add body   "$(md2html $SRC/$file.md)"
            add footer "$(md2html $SRC/footer.md)"

            # close document
            printf '%s\n' '</html>'
        } >>$OUT/$file$ext &

        # unset ext as not to carry over to next file
        unset ext
    done
    # wait for conversion jobs to finish
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
