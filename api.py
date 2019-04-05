from flask import Flask, render_template
from get_data import get_data
import os
app = Flask(__name__, static_folder="frontend/static", template_folder="frontend/static")

@app.route("/")
def index():

  return render_template("dashboard.html")


@app.route("/hello")
def hello():
  return "Hello World!!!!!!!!!!!!!!!!!!!!!!!"

@app.route("/settings")
def setting():
  return "Setting"

if __name__ == "__main__":
  app.run(host='0.0.0.0', port=2000, threaded=True)
