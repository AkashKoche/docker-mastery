from flask import Flask, render_template_string
import requests
import os

app = Flask(__name__)
BACKEND_URL = os.getenv('BACKEND_URL', 'http://backend:5000')

HTML_TEMPLATE = '''
<!DOCTYPE html>
<html>
<head>
    <title>Advanced Docker Compose App</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .service { margin: 20px 0; padding: 15px; border-left: 4px solid #007cba; background: #f5f5f5; }
        .error { border-left-color: #dc3232; background: #fbeaea; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Advanced Docker Compose Demo</h1>
        <div class="service">
            <h2>Frontend Service</h2>
            <p><strong>Container ID:</strong> {{ frontend_id }}</p>
            <p><strong>Environment:</strong> {{ environment }}</p>
        </div>
        {% if backend_data %}
        <div class="service">
            <h2>Backend Service</h2>
            <p><strong>Message:</strong> {{ backend_data.message }}</p>
            <p><strong>Database:</strong> {{ backend_data.database_version }}</p>
            <p><strong>Container ID:</strong> {{ backend_data.container_id }}</p>
        </div>
        {% else %}
        <div class="service error">
            <h2>Backend Service - Unavailable</h2>
            <p><strong>Error:</strong> {{ backend_error }}</p>
        </div>
        {% endif %}
    </div>
</body>
</html>
'''

@app.route('/')
def home():
    frontend_id = os.uname().nodename
    environment = os.getenv('APP_ENV', 'development')
    
    backend_data = None
    backend_error = None
    
    try:
        response = requests.get(f"{BACKEND_URL}/api/data", timeout=5)
        if response.status_code == 200:
            backend_data = response.json()
        else:
            backend_error = f"HTTP {response.status_code}"
    except Exception as e:
        backend_error = str(e)
    
    return render_template_string(HTML_TEMPLATE,
        frontend_id=frontend_id,
        environment=environment,
        backend_data=backend_data,
        backend_error=backend_error
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
