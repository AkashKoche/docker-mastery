from flask import Flask
import redis
import os

app = Flask(__name__)
# The host='redis' is the service name defined in docker-compose.yml
redis_client = redis.Redis(host='redis', port=6379, decode_responses=True)

@app.route('/')
def hello():
    # Increment the visitor count
    count = redis_client.incr('visits')
    return f'<h1>Hello Docker Compose!</h1><h3>You are visitor number: {count}</h3>'

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
