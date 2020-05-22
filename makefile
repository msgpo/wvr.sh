REMOTE_DIR = /var/www/html
HOST = wvr
OUT = ./www/html
SRC = ./src

all: build copy

build:
	sssg -s ${SRC} -o ${OUT}
	sassc ${SRC}/start/scss/style.scss ${SRC}/start/style.css
	cp -rf ${SRC}/start ${OUT}/
	find src/blog/2020 -maxdepth 1 -type d ! -path '*blog/2020' | \
	while read -r dir ; do \
		mkdir -p www/html/blog/2020 ; \
		cp -rf "$${dir}" "www/html/$${dir##*src/}" ; \
	done

copy:
	rsync -rvhtuc --progress --delete --exclude u ${OUT}/ ${HOST}:${REMOTE_DIR}
