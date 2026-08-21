from flask import Flask
import redis
import os
import time

app = Flask(__name__)
redis_host = os.getenv("REDIS_HOST", "redis")
redis_client = None


def get_redis_client():
    global redis_client
    retries = 10
    while retries > 0:
        try:
            rc = redis.Redis(host=redis_host, port=6379, socket_timeout=2)
            rc.ping()
            redis_client = rc
            return
        except Exception:
            retries -= 1
            time.sleep(1)
    raise RuntimeError("Could not connect to redis")


get_redis_client()


@app.route('/')
def index():
    redis_client.incr('visit_counter')
    visits = redis_client.get('visit_counter').decode()
    return f"<h1>K3d 3‑Tier Demo</h1><p>Visit Count: {visits}</p>"


@app.route('/health')
def health():
    return "ok", 200


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
