# Run Application

    docker-compose up -d

# Networking

    docker network ls

    docker network inspect <project_folder_name>_default

# Test Service Discovery

    docker-compose exec web sh

    ping redis

    nslookup redis

    python
    import redis
    r = redis.Redis(host='redis', port=6379)
    r.ping()
    True
    exit()
