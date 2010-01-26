int ledPin = 13;
int inByte = 0;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
  Serial.println("hello world");
}

void loop(){
  if (Serial.available() > 0) {
    inByte = Serial.read();
    if (inByte == 'a') {
      digitalWrite(ledPin, HIGH);
      Serial.println("200 ok led on");
    }
    else if (inByte == 'b') {
      digitalWrite(ledPin, LOW);
      Serial.println("200 ok led off");
    }
    else {
      Serial.println("500 error unknown command...");
    }
  }
}
