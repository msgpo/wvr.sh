REMOTE_DIR = /var/www/html
HOST = wvr
OUT = ./www/html
SRC = ./src

all: build copy

build:
	sssg -s ${SRC} -o ${OUT}
	cp -rf ${SRC}/start ${OUT}/

copy:
	rsync -rvhtuc --progress --delete ${OUT}/ ${HOST}:${REMOTE_DIR}
