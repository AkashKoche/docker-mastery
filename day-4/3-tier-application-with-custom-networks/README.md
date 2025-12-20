# Run Application

    docker-compose up -d

    docker-compose exec frontend ping db

    docker-compose exec frontend ping backend

    docker-compose exec backend ping db

    localhost:8000

# Manual Service Discovery

    docker network create --driver bridge my-custom-network

    docker run -d --name manual-web --network my-custom-network nginx:alpine

    docker run -d --name manual-db --network my-custom-network redis:alpine

    docker exec manual-web ping manual-db

    docker network inspect my-custom-network

# Test Network Drivers

    docker run -d --name host-network-test --network host nginx:alpine

    curl http://localhost

    docker rm -f host-network-test
