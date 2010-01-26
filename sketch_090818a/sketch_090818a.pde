int pin_in_lm60 = 0;    // select the input pin for the potentiometer
int count = 0;

void setup() {
  analogReference(INTERNAL);
  Serial.begin(9600);
}

void loop() {
  int val = analogRead(pin_in_lm60);
  Serial.println(val);
  delay(2000);
}
