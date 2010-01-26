#include <Ethernet.h>



// temperature
int pin_in_lm35 = 0;
int t_count = 0;
int t_count_max = 60;
float t_total = 0;
float t_temp = 0;

void setup() {
  analogReference(INTERNAL);
  Serial.begin(9600);
}

void loop() {
  int val = analogRead(pin_in_lm35);    
  float lm35_vout_volt = val * 1.1 / 1024;
  float t = lm35_vout_volt * 100.0;
  t_total += t;
  
  t_count++;
  if (t_count == t_count_max) {
    t_temp = t_total / t_count_max;
    Serial.println(t_temp);
    t_total = 0.0;
    t_count = 0;
  }
 
  delay(1000);
}
