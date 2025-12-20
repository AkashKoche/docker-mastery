# List Networks

    docker network ls

# Default Bridge Network

    docker run -d --name test-container1 nginx:alpine

    docker run -d --name test-container2 nginx:alpine

    docker network inspect bridge

    docker exec test-container1 ping test-container2

    docker exec test-container1 ping <container2_ip_address>
