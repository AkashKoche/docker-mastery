docker build -t spring-boot-app .

docker run -d -p 8080:8080 spring-boot-app

docker inspect <container-id> | grep Health

http://localhost:8080/hello
