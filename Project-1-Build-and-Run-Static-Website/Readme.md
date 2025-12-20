docker build -t my-static-website .

docker run -d -p 80:80 my-static-website

docker login

docker tag my-static-website <dockerhub-username>/my-static-website

docker push <dockerhub-username>/my-static/website

docker inspect <container-id>

docker inspect --format='{{.NetworkSetting.IPAddress}}' <container-id>

docker start <container-id>
docker stop <container-id>
docker restart <container-id>
docker rm <container-id>
docker run --rm <image-name>

docker stats

docker run -it alpine /bin/sh

docker tag my-static-website <your-dockerhub-username>/my-static-website:v1.0.0

docker push <your-dockerhub-username>/my-static-website:v1.0.0

docker history <image-name>

docker run -d --memory="512m" --cpus="0.5" nginx

docker system prune -a

docker volume prune
