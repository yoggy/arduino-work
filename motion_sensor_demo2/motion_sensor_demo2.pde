int pin_sonsor = 0;  // analog pin for Motion Sensor
int pin_led = 11;    // digital pin for LED

unsigned short sensor_val        = 0;
unsigned char  sensor_status     = LOW;

unsigned int count = 0;
unsigned int start_count = 500;
unsigned int half_count;

void setup() {
  Serial.begin(9600);
  pinMode(pin_led, OUTPUT);

  half_count = start_count / 2;
}

void loop() {
  // read value from sensor
  sensor_val = analogRead(pin_sonsor);

  // set sensor status. 1:ON, 0:OFF
  sensor_status =  sensor_val > 500 ? HIGH : LOW;

  // send status string, and start blinking led
  if (sensor_status && count == 0) {
    count = start_count;
    Serial.println("ON");
  }

  // calc led brightness
  float p;
  if (count > half_count) {
    // 0.0 -> 1.0
    p = (start_count - count) / (float)half_count;
  }
  else {
    // 1.0 -> 0.0
    p = count / (float)half_count;
  }
  int brightness = (int)(30 * p);
  
  // set led status
  analogWrite(pin_led, brightness);

  
  if (count > 0) count--;

  delay(10);
}
