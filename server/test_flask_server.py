from flask import Flask, request, jsonify

app = Flask(__name__)

data = {"distance": 90}


@app.route('/')
def index():
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
