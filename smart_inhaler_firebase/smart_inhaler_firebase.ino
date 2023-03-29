// DHT 11 sensor
#include <DHT.h>
#define DHTPIN 0
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
float humidity;
float temp;

// Push Button
int buttonPin = 4;
int dailyIntake = 0;
int medicineVal = 10;
int medicine_threshold = 3;

// MQ 135
int aqi = 0;


// https://smart-inhaler-aa31c-default-rtdb.europe-west1.firebasedatabase.app/
// AIzaSyD9-X-90ALIVmCURtsMr-pHR5YIfA-88u0 
#include <Arduino.h>
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert your network credentials
#define WIFI_SSID "IT303AP"
#define WIFI_PASSWORD "lab303ap"

// Insert Firebase project API Key
#define API_KEY "AIzaSyD9-X-90ALIVmCURtsMr-pHR5YIfA-88u0"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "https://smart-inhaler-aa31c-default-rtdb.europe-west1.firebasedatabase.app/" 

//Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;

void setup(){
  Serial.begin(115200);
  pinMode(buttonPin, INPUT);
  dht.begin();

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop(){
  // Read Values
  // if(digitalRead(buttonPin) == HIGH){
  //   dailyIntake += 1;
  //   medicineVal -= 1;
  //   if (medicineVal == 0){
  //     medicineVal += 10;
  //     Serial.println("Medicine added!");
  //   }
  // }
  // delay(500);

  aqi = analogRead(A0);
  delay(500);
  humidity = dht.readHumidity();
  delay(1000);
  temp = dht.readTemperature();
  delay(1000);

  // Upload values to firebase
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();
    // Write an Int number on the database path test/int
    if (Firebase.RTDB.setInt(&fbdo, "data/daily intake", dailyIntake)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
      Serial.print("Daily Intake count: ");
      Serial.println(dailyIntake);
      Serial.print("Medicine Value: ");
      Serial.println(medicineVal);
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setInt(&fbdo, "data/medicine value", medicineVal)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setInt(&fbdo, "data/aqi", aqi)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
      Serial.print("Air Quality Index: ");
      Serial.println(aqi);
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    
    // Write an Float number on the database path test/float
    if (Firebase.RTDB.setFloat(&fbdo, "data/temperature", temp)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
      Serial.print("Temperature: ");
      Serial.println(temp);
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "data/humidity", humidity)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
      Serial.print("Humidity: ");
      Serial.println(humidity);
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
  }

  if(digitalRead(buttonPin) == HIGH){
    dailyIntake += 1;
    medicineVal -= 1;
    if (medicineVal == 0){
      medicineVal += 10;
      Serial.println("Medicine added!");
    }
  }
  delay(500);
}
