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

Esto es necesario para que el servidor nginx pueda acceder a los contenedores

```console
docker network connect other-network nginx-proxy
```

### Nota

Si al intentar acceder al sitio web usando el dominio asignado se muestra el estado 301 de redireccionamiento intentar eliminar la variable de entorno `LETSENCRYPT_HOST` y vuelve a crear el contenedor

### Otras comandos

Inspeccionar la configuracion generada por nginx-proxy

```console
docker exec nginx-proxy nginx -T
```
