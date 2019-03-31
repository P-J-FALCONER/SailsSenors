#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <DHT.h>
#define DHTTYPE DHT22
#define DHTPIN 4

const char* ssid     = "******";
const char* password = "******";

ESP8266WebServer server(80);
 
// Initialize DHT sensor 
DHT dht(DHTPIN, DHTTYPE);
 
float humidity, temp_f; // Values read from sensor
unsigned long previousMillis = 0; // will store last temp was read
const long interval = 2000; // interval at which to read sensor
 
void handle_root() {
  gettemperature();
  String message = "{";
  message += "\"Temperature\":";
  message += String((int)temp_f);
  message += ",\n";
  message += "\"Humidity\":";
  message += String((int)humidity);
  message += "}";
  server.send(200, "application/json", message);
}

void setup(void)
{
  Serial.begin(115200);  // Serial connection from ESP-01 via 3.3v console cable
  dht.begin();           // initialize temperature sensor

  // Connect to WiFi network
  WiFi.begin(ssid, password);
  Serial.print("\n\r \n\rWorking to connect");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
   
  server.on("/", handle_root);
  server.begin();
}
 
void loop(void)
{
  server.handleClient();
} 

void gettemperature() {
  unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;   
    humidity = dht.readHumidity();
    temp_f = dht.readTemperature(true);
    if (isnan(humidity) || isnan(temp_f)) {
      Serial.println("Failed to read from DHT sensor!");
      return;
    }
  }
}