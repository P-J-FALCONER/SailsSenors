from flask import Flask
from get_data import get_data
app = Flask(__name__)
 
@app.route("/")
def dashboard():
  data = get_data()
  return "Dashboard"

@app.route("/settings")
def setting():
  return "Setting"

 
if __name__ == "__main__":
  app.run()