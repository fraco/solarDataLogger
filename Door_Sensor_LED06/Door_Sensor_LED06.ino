//Elevators//
int ledPin = 2;
int ledPinGreen = 4;
int switchPin7 = 6;
int switchPin8 = 7;
int value = 0;

int switchPushCounter = 0;
int switchState7 = 0;
int switchState8 = 0;
int switchState = 0;
int lastSwitchState7 = 0;

int lastSwitchState8 = 0;
int finalSwitchState = 0;
//Elevators//

//Stairs//
int ledPinRed = 5;
int switchPin9 = 8;

int switchPushCounter9 = 0;
int switchState9 = 0;
int lastSwitchState9 = 0;
//Stairs//

void setup() {
  Serial.flush();
  delay(2000);
  pinMode(switchPin7, INPUT);
  pinMode(switchPin8, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(ledPinGreen, OUTPUT);
  pinMode(switchPin9, INPUT);
  pinMode(ledPinRed, OUTPUT);

  Serial.begin(9600);
}

void loop() {
//  Serial.flush();
  
  //ELEVATORS// E1
  switchState7 = digitalRead(switchPin7);
  switchState8 = digitalRead(switchPin8);

  if ( lastSwitchState7 != switchState7 ) {
    if ( switchState7 == 0 ) {   //both close
    }
    else {
    }
    lastSwitchState7 = switchState7;
  }  
  digitalWrite(ledPin, switchState7);

  //E2
  if ( lastSwitchState8 != switchState8 ) {
    if ( switchState8 == 0 ) {   //both close
    }
    else {
    }
    lastSwitchState8 = switchState8;
  }
  digitalWrite(ledPinGreen, switchState8);
  //Elevators//

  ///--------------------

  //STAIRS//
  switchState9 = digitalRead(switchPin9);
  if (switchState9 != lastSwitchState9) {
    if (switchState9 == 0) {
    }
    else {
    }
    lastSwitchState9 = switchState9;
  }
  digitalWrite(ledPinRed, switchState9);
  //Stairs//

  Serial.print(lastSwitchState7);
  Serial.print(',');
  Serial.print(lastSwitchState8);
  Serial.print(',');
  Serial.println(lastSwitchState9);

  delay(1000);

}




