docker-compose up -d

docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

docker-compose down -v

docker-compose up -d
