/*
******************************************************************************************************************************************************************
*
* Markisol iFit Spring Pro 433.92MHz window shades
* Also sold under the name Feelstyle and various Chinese brands like Bofu
* Compatible with remotes like BF-101, BF-301, BF-305, possibly others
* 
* Original Code by Antti Kirjavainen (antti.kirjavainen [_at_] gmail.com)
* Modifications by Mark Edwards (shades66 [_at_] gmail.com)
*
* Based on https://github.com/akirjavainen/markisol/blob/9cc13ec5d3d22195338b0c3d53bc853951cf1b29/Markisol.ino
*
* Modifcations to allow use within ESPHome.  tested on an ESP32 only
*
* Note:  If you are already using an RF transmitter to send codes to other devices this does not play nicely using the same transmit pin.  I've found using 470ohm resistors in line of both GPIO's to the RF Transmitters data pin
*
*
* to use as a switch within ESPHome you can use the following example.
*
* switch:
*   - platform: template
*     name: "Blind Down"
*     turn_on_action:
*       lambda: sendMarkisolCommand("10111011111011111000100010000011110110101");
*
*
* This can be triggered from other ESPHome devices as follows (taken from my ESPHome setup connected to a Nextion screen)
*
* binary-sensor:
*   - platform: nextion
*     name: $device_name Blind Up
*     page_id: 2
*     component_id: 16
*     on_release:
*       - homeassistant.service:
*           service: switch.toggle
*           data:
*             entity_id: switch.blind_up_2
*
*
*/

#include "esphome.h"


#define TRANSMIT_PIN                       27   // We'll use digital 13 for transmitting

#define MARKISOL_AGC1_PULSE                   4885  // 216 samples
#define MARKISOL_AGC2_PULSE                   2450  // 108 samples
#define MARKISOL_AGC3_PULSE                   1700  // 75 samples
#define MARKISOL_RADIO_SILENCE                5057  // 223 samples

#define MARKISOL_PULSE_SHORT                  340   // 15 samples
#define MARKISOL_PULSE_LONG                   680   // 30 samples

#define MARKISOL_COMMAND_BIT_ARRAY_SIZE       41    // Command bit count

#define REPEAT_COMMAND                      8   // How many times to repeat the same command: original remotes repeat 8 (multi) or 10 (single) times by default
#define DEBUG                           false   // Do note that if you print serial output during transmit, it will cause delay and commands may fail


void transmitHigh(int delay_microseconds) {
  digitalWrite(TRANSMIT_PIN, HIGH);
  //PORTB = PORTB D13high; // If you wish to use faster PORTB calls instead
  delayMicroseconds(delay_microseconds);
}

void transmitLow(int delay_microseconds) {
  digitalWrite(TRANSMIT_PIN, LOW);
  //PORTB = PORTB D13low; // If you wish to use faster PORTB calls instead
  delayMicroseconds(delay_microseconds);
}

void errorLog(String message) {
  Serial.println(message);
}

void doMarkisolTribitSend(char* command) {

  // Starting (AGC) bits:
  transmitHigh(MARKISOL_AGC1_PULSE);
  transmitLow(MARKISOL_AGC2_PULSE);
  transmitHigh(MARKISOL_AGC3_PULSE);
  if (DEBUG) { Serial.println(""); Serial.print("Sending :"); }
  // Transmit command:
  for (int i = 0; i < MARKISOL_COMMAND_BIT_ARRAY_SIZE; i++) {

      // If current bit is 0, transmit LOW-HIGH-LOW (010):
      if (command[i] == '0') {
      if (DEBUG) { Serial.print("0"); }
        transmitLow(MARKISOL_PULSE_SHORT);
        transmitHigh(MARKISOL_PULSE_SHORT);
        transmitLow(MARKISOL_PULSE_SHORT);
      }

      // If current bit is 1, transmit LOW-HIGH-HIGH (011):
      if (command[i] == '1') {
      if (DEBUG) { Serial.print("1"); }
        transmitLow(MARKISOL_PULSE_SHORT);
        transmitHigh(MARKISOL_PULSE_LONG);
      }   
   }

  if (DEBUG) {
    Serial.println();
    Serial.print("Transmitted ");
    Serial.print(MARKISOL_COMMAND_BIT_ARRAY_SIZE);
    Serial.println(" bits.");
    Serial.println();
  }
}

void sendMarkisolCommand(std::string comm) {

  char *command = new char[comm.length() + 1];
  strcpy(command, comm.c_str());
  
  if (command == NULL) {
    errorLog("sendMarkisolCommand(): Command array pointer was NULL, cannot continue.");
    return;
  }

  // Prepare for transmitting and check for validity
  pinMode(TRANSMIT_PIN, OUTPUT); // Prepare the digital pin for output
  
  if (strlen(command) < MARKISOL_COMMAND_BIT_ARRAY_SIZE) {
    errorLog("sendMarkisolCommand(): Invalid command (too short), cannot continue.");
    return;
  }
  if (strlen(command) > MARKISOL_COMMAND_BIT_ARRAY_SIZE) {
    errorLog("sendMarkisolCommand(): Invalid command (too long), cannot continue.");
    return;
  }
  
  // Repeat the command:
  for (int i = 0; i < REPEAT_COMMAND; i++) {
    doMarkisolTribitSend(command);
  }

  // Radio silence at the end of last command.
  // It's better to go a bit over than under minimum required length:
  transmitLow(MARKISOL_RADIO_SILENCE);


  // Disable output to transmitter to prevent interference with
  // other devices. Otherwise the transmitter will keep on transmitting,
  // disrupting most appliances operating on the 433.92MHz band:
  digitalWrite(TRANSMIT_PIN, LOW);
  delete [] command;
}