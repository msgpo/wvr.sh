HOST = wvr
DIR  = /var/www/html

all:
	rsync -rvhtuc --progress --delete ./www/html/ ${HOST}:${DIR}
