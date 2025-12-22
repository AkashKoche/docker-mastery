# Multiple Compose Files & Overrides

	docker-compose up -d

	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

	docker-compose config

# Resource Management

	docker stats

	docker inspect <container_id> | grep -A 10 "HostConfig"

# Advanced Networking with Static IPs

	docker-compose exec frontend ping 10.20.0.20

	docker network inspect advanced-compose_backend_net

# Health Checks and Dependency Management

	watch -n 2 'docker-compose ps'

	curl http://localhost:8080/api/health

# Security Features

	docker-compose exec backend whoami

	docker-compose -f docker-compose.yml -f docker-compose.prod.yml exec backend touch /tmp/test

# Development Environment

	docker-compose up -d --build

	docker compose watch

	docker-compose logs -f

# Production Simulation

	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

	docker-compose -f docker-compose.yml -f docker-compose.prod.yml ps
