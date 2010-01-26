int pin_servo = 3;
int count_for_serial_buf_clear = 100;

int angle = 1000;

void setup() {
  Serial.begin(38400);
}

void loop() {
  int val = analogRead(1);
  Serial.println(val);
}
