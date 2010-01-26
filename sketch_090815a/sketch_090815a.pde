int pin_in_lm60  = 0;

int temp = 0;
int count = 0;

void setup() 
{
  Serial.begin(9600);
  Serial.println("200 lm60 test...");
}

void loop() 
{
  // get LM60 Value
  temp = analogRead(pin_in_lm60);
  
  count++;
  if (count > 1000) {
    Serial.println(temp);
    count = 0;
  }
}
