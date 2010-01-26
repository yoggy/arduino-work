int idx = 0;
int d = 1;

void setup()
{                
  // initialize the digital pin as an output:
  for (int i = 0; i < 8; ++i) {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }

  pinMode(10, INPUT);
}

void loop()                     
{
  int val = digitalRead(10);
  if (val == HIGH) {
    for (int i = 0; i < 8; ++i) {
      if (idx == i)  digitalWrite(i, HIGH);
      else           digitalWrite(i, LOW);      
    }
    if (idx == 0)   d = 1;
    if (idx == 7)   d = -1;
    idx += d;      
  }
  else {
    // reset
    idx = 0;
    d = 0;  
    for (int i = 0; i < 8; ++i) {
      digitalWrite(i, LOW);
    }
  }
  delay(30);
}
