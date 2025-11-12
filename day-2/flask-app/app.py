from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # Use an environment variable with a default value
    name = os.getenv('NAME', 'Docker Learner')
    return f'<h1>Hello, {name}!</h1><p>Welcome to your first containerized Flask app.</p>'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
