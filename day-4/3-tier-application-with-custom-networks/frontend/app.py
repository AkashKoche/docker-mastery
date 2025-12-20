from flask import Flask
import requests
import os

app = Flask(__name__)
BACKEND_URL = os.getenv('BACKEND_URL', 'http://backend:5000')

@app.route('/')
def home():
    try:
        # Try to get data from backend API
        response = requests.get(f"{BACKEND_URL}/api/data")
        if response.status_code == 200:
            data = response.json()
            return f'''
            <h1>Three-Tier Docker Application</h1>
            <h2>Frontend Container: {os.uname().nodename}</h2>
            <h3>Backend says: {data['message']}</h3>
            <p>Database: {data['database_version']}</p>
            <p>Backend Container: {data['container_id']}</p>
            '''
        else:
            return f'<h1>Error reaching backend: {response.status_code}</h1>'
    except Exception as e:
        return f'<h1>Cannot connect to backend: {str(e)}</h1>'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
