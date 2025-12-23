# Create a test job in Jenkins
curl -X POST "http://localhost:8080/job/test/createItem?name=persistence-test" \
  -u admin:admin123 \
  -H "Content-Type: application/xml" \
  -d '<project><builders/><publishers/><buildWrappers/></project>'

# Verify the job was created
curl -s "http://localhost:8080/api/json" | jq '.jobs[] | .name'

# Completely destroy and recreate the container
docker-compose stop jenkins
docker-compose rm jenkins
docker-compose up -d jenkins

# Wait for startup, then verify the job still exists
sleep 30
curl -s "http://localhost:8080/api/json" | jq '.jobs[] | .name'

# Build and push an image to the local registry using dind
docker-compose exec dind sh -c "
  docker build -t localhost:5000/test-image:latest - <<<'FROM alpine:latest'
  docker push localhost:5000/test-image:latest
"

# Verify the image is in the registry
curl -s http://localhost:5000/v2/_catalog | jq

# Restart the dind container
docker-compose restart dind

# The image should still be available in the registry
curl -s http://localhost:5000/v2/_catalog | jq
