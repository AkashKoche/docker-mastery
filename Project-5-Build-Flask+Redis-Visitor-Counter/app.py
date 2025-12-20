from flask import Flask
import redis

app = Flask(__name__)
# Connect to Redis
cache = redis.Redis(host='redis', port=6379)

@app.route('/')
def hello():
    # Increment the visitor count in Redis
    count = cache.incr('visits')
    return f"Hello Dockerized World! You've visited this page {count} times."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
