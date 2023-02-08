// Push Button
int pushButton = 2;
int buttonState = 0;
int medicineVal = 0;
int medicine_threshold = 7;

void setup() {
  // put your setup code here, to run once:
  Serial.print("Threshold of medication? ");

  while (Serial.available() == 0) {
  }

  medicineVal = Serial.parseInt();
  pinMode(pushButton, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(pushButton);
  if(buttonState == HIGH){
    if(buttonState < medicine_threshold){
      Serial.println("Warning!! Low medicine Levels");
    }
    else{
      Serial.println(buttonState);
    }
  }
  buttonState -= 1;
  delay(2000);
}
