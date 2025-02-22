### Para que es esto ?

Este proyecto es una configuración de nginx-proxy para que se puedan usar
los contenedores de docker en un servidor linux y mostrarlos usando un dominio web.

### Como asignar un dominio a un contenedor

El contenedor a desplegar debe de tener las siguiente variable de entorno

- `VIRTUAL_HOST`
- `LETSENCRYPT_HOST`
- `VIRTUAL_PORT`

`VIRTUAL_HOST` y `LETSENCRYPT_HOST` ambos deben ser iguales al dominio que se quiere asignar.

`VIRTUAL_PORT` es el puerto en donde el servicio está escuchando.

Ejemplo:

```console
$ docker run --detach \
    --name grafana \
    --env "VIRTUAL_HOST=othersubdomain.yourdomain.tld" \
    --env "LETSENCRYPT_HOST=othersubdomain.yourdomain.tld" \
    --env "VIRTUAL_PORT=3000" \
    grafana/grafana
```

### Como conectar una red de otro contenedor a nginx-proxy

```console
docker network connect other-network nginx-proxy
```

### Como usar archivos staticos en nginx-proxy

1- Entrar al volumen `vhost`

- Obtener la ruta: `docker volume inspect vhost`

2- Copiar configuracion.

Ejemplo de configuracion para un app django:

```
location /static/ {
    alias /home/app/web/staticfiles/;
    add_header Access-Control-Allow-Origin *;
}
```

3- Editar el archivo `makefile` para agregar el volumen donde
estan guardados los archivos estaticos del servidor web

Agregar esta linea (ejemplo):

```
--volume botonera-tg-pro_static_volume:/home/app/web/staticfiles \
```

### Como conectar una red usada por otro contenedor a la red de nginx-proxy

```console
docker network connect other-network nginx-proxy-network
```
