/**
 * ScopeAnalog
 *
 *
 * Copyright 2009 Jonathan Oxer <jon@oxer.com.au>
 * Copyright 2009 Hugh Blemings <hugh@blemings.org>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version. http://www.gnu.org/licenses/
 *
 * www.practicalarduino.com/projects/scope-logic-analyzer
 */

/**
 * Define macros for setting and clearing bits in the ADC prescale register
 */
#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif

int val;

/**
 * Sets the ADC prescaler to 16, prepares the relevant digital inputs,
 * and opens serial comms with the host
 */
void setup()
{
  sbi(ADCSRA,ADPS2);
  cbi(ADCSRA,ADPS1);
  cbi(ADCSRA,ADPS0);
  pinMode(6, INPUT);
  pinMode(7, INPUT);
  Serial.begin(115200);
}

/**
 * Read the inputs and send values to the host. The analog read values
 * from the digital inputs need to be fudged so they read 0 or 1023
 */
void loop()
{
  for( int i=0; i<6; i++ ){
    Serial.print( analogRead(i) );
    Serial.print(" ");
  }

  if( digitalRead(6) == 1){
    Serial.print(1023);
    Serial.print(' ');
  } else {
    Serial.print(0);
    Serial.print(' ');
  }

  if( digitalRead(7) == 1){
    Serial.print(1023);
  } else {
    Serial.print(0);
  }

  Serial.println();
}
