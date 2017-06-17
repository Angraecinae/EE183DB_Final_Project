#include <avr/io.h>
#include <avr/interrupt.h>

volatile unsigned long rising = 0;
volatile unsigned long falling = 0;

volatile double runningAvg = 0;
volatile double count = 1;
volatile bool proceed = false;

double norm = 1;

void risingEdgeDetect() {
  rising = micros();
}
void fallingEdgeDetect() {
  falling = micros();
  runningAvg = (runningAvg + (double) (falling - rising));
  if (count == 200) {
    noInterrupts();
    runningAvg /= count;
    proceed = true;
  }
  count++;
}


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  while(!Serial);
  pinMode(14, INPUT);
  pinMode(15, INPUT);
  pinMode(16, OUTPUT);
  pinMode(17, OUTPUT);
  pinMode(18, INPUT);
  pinMode(19, INPUT);
  attachInterrupt(digitalPinToInterrupt(14), risingEdgeDetect, RISING);
  attachInterrupt(digitalPinToInterrupt(15), fallingEdgeDetect, FALLING);
  digitalWrite(13, HIGH);
}

double phaseDelay = 0;

void loop() {
  noInterrupts();
  runningAvg = 0;
  count = 1;
  proceed = false;
  detachInterrupt(digitalPinToInterrupt(14));
  detachInterrupt(digitalPinToInterrupt(15));
  interrupts();
  attachInterrupt(digitalPinToInterrupt(18), risingEdgeDetect, RISING);
  attachInterrupt(digitalPinToInterrupt(19), fallingEdgeDetect, FALLING);
  while(!proceed) {
    
  }
  norm = runningAvg;
  detachInterrupt(digitalPinToInterrupt(18));
  detachInterrupt(digitalPinToInterrupt(19));
  interrupts();
  attachInterrupt(digitalPinToInterrupt(14), risingEdgeDetect, RISING);
  attachInterrupt(digitalPinToInterrupt(15), fallingEdgeDetect, FALLING);  
  noInterrupts();
  // 1 and 2
  digitalWrite(16, LOW);
  digitalWrite(17, LOW);
  runningAvg = 0;
  count = 1;
  proceed = false;
  interrupts();
  while (!proceed) {
    
  }
  Serial.print("1/2 : ");
  phaseDelay = norm - runningAvg;
  Serial.println(phaseDelay);
  // 1 and 3
  digitalWrite(16, HIGH);
  digitalWrite(17, LOW);
  runningAvg = 0;
  count = 1;
  proceed = false;
  interrupts();
  while (!proceed) {
    
  }
  Serial.print("1/3 : ");
  phaseDelay = norm - runningAvg;
  Serial.println(phaseDelay);
  // 1 and 4
  digitalWrite(16, LOW);
  digitalWrite(17, HIGH);
  runningAvg = 0;
  count = 1;
  proceed = false;
  interrupts();
  while (!proceed) {
    
  }
  Serial.print("1/4 : ");
  phaseDelay = norm - runningAvg;
  Serial.println(phaseDelay);

  
}
