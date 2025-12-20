docker build -t flask-app .

docker run -d -p 5000:5000 flask-app

docker logs <container_id>

docker exec -it <container_id> /bin/sh

##RUN adduser --disable-password --gecos "" appuser
##USER appuser
##ARG VERSION=1.0
##ENV APP_VERSION=${VERSION}

dive <image-name>

trivy image <image-name>

DOCKER_BUILDKIT=1 docker build -t my-app .
