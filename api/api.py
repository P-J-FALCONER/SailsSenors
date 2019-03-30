from flask import Flask
app = Flask(__name__)
 
@app.route("/")
def dashboard():
  return "Dashboard"

@app.route("/water_temp")
def water_temp():
  return "Water Temp"

@app.route("/wind")
def wind():
  return "Wind"

@app.route("/boat_speed")
def boat_speed():
  return "Boat Speed"

@app.route("/lights")
def lights():
  return "lights"

@app.route("/weather")
def weather():
  return "weather"
 
if __name__ == "__main__":
  app.run()