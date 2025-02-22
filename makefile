# Mapear en este comando los volumenes que contienes
# los archivos estaticos
run:
	docker run -d \
    --name nginx-proxy \
    --publish 80:80 \
    --publish 443:443 \
	--volume botonera-tg-pro_static_volume:/home/app/web/staticfiles \
    --volume certs:/etc/nginx/certs \
    --volume html:/usr/share/nginx/html \
	--volume vhost:/etc/nginx/vhost.d \
    --volume /var/run/docker.sock:/tmp/docker.sock:ro \
	--restart always \
    nginxproxy/nginx-proxy


logs:
	docker logs nginx-proxy -f


delete:
	docker stop nginx-proxy
	docker rm nginx-proxy
	docker rmi custom-nginx-proxy-image




