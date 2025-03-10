This is some detail about hacking a larger AliExpress clock to work with ESPHome.  The clock has  6659 written on the box and on the rear of the clock has DS-6638

The description is 
    "LED Digital Wall Clock Temperature Date Week Display Table Alarm Clocks Voice Control Electronic Clock Brightness Adjustment"

  See Image D in this directory.

  Link working on the 19/2/2024  https://vi.aliexpress.com/item/1005007302669392.html?spm=a2g0o.order_list.order_list_main.5.21ef1802SmpRxY&gatewayAdapt=glo2vnm

This is a continuation of attempting to modify a cheap led clock from AliExpress to work via ESPHome for use in home assistant.  See the other clock up one directory for details of what I found there.

Opening the clock
-----------------
The front black filter can be peeled off pretty easily once you manage to lift one of the corners using your nails or a very thin blade. Be very carefull pulling the screen off in one go as it snaps if bent too far away from the case..   Once removed there are 6 small screws which allow the front to be removed gaining access to the main PCB.

See Image E

I was expecting a similar PCB to the previous clock where it would be easy to identify the main pins in order to hack on an ESP32 chip to drive it.  Instead I found a pretty cheap one sided PCB with hundreds of SMD zero ohm resistors which allow tracks to jump over each other without physical links, along with 2 chips in the centre which helpfully had all identification removed... The larger chip is what is driving the LED's but I had no idea how

I checked a few driver chips and the closest I could find was the Holteck HT16D33A which I found the I2C connection on pins 8 & 9 after probing with a logic analyzer but the data I could see being sent to this chip did not appear to match what was in datasheet and the power pins didn't seem to match the datasheet either.  

***  I SUSPECT THE DRIVER CHIP IS THE TM1640.   SEE Datasheet in this repo. ******

See image F for a number of traces I found.
    Top image is what is sent on powering up the clock
    next 3 are just random ones taken to see any obvious difference
    last 3 are after adjusting the screen brightness

I removed a few resistors to allow me to use an ESP32 to drive the main chip.

   Image A shows the I2C pins.  
         The 2 to the left are the I2C pullups which pull to 5 volts which I'm not sure the ESP32 would like
         The 2 under the chip are what connect to the microcontroller
   Image B shows the same pins but I've moved the resistors onto single pads.  Note I did this wrong on the photo, the 2 resistors i moved to the pads I soldered onto and on my final implementation moved to hang onto the bottom 2 pads.  The wired for CLK & DATA I attached to the pads you see the where 2 resistors are shown to be soldered under the chip. (hope that makes sense)

   The 2 wires for CLK & DATA i then routed straight down and to the other side of the board where you will find some space to mount whatever ESP board you are using.  For my hack I used the ESP32-Pico-V2-MiniPICO (See in the ESP32Board section of my repo) I created which is taped to the back of the PCB with power being tapped off the capacitor on the back of the PCB near the DJ Jack and an antenna stuck to the rear of the plastic casing.

   For power see image C.  


from the top image (image F) I found I could replicate the power up screen which is at full brightness & all digits lit up via ESPHome the following code

            id(i2cdev).write_byte(0x12, 0x01);   
            id(i2cdev).write_byte(0x10, 0x0f); 
            id(i2cdev).write_byte(0x11, 0x0f);
            id(i2cdev).write_bytes(0x00, { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff });           
            id(i2cdev).write_byte(0x12, 0x03);

after that the microcontroller just repeats the following every second 

              id(i2cdev).write_byte(0x10, 0x0f); 
              id(i2cdev).write_byte(0x11, 0x0f);
              id(i2cdev).write_bytes(0x00, { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff });           
              id(i2cdev).write_byte(0x12, 0x03);

from this I just found the following 2 commands would be of use

             Command  0x10   Data 0xXX   Brightness,  seems to have few different levels between 0 & 15
             Command  0x00   Data  16 x 8bit bytes

             Command 0x11 Data 0x0f  - not sure so I just copied it for now
             Command 0x12 Data 0x03  - not sure so I just copied for now.  Possibly a command to update the led outputs?  


after a few hours of messing around with the block of 16 bytes I came up with the following

 See the ESPHOME YAML.txt file for the full code which includes the i2c & i2c_device setup definitions used by the following

time:
  - platform: homeassistant
    id: homeassistant_time
    # ...
    on_time:
      # Every second minutes
      - seconds: 0-59
        then:
          - lambda: !lambda |- 
              //  The 2 arrays used to draw digits & the day of week starting from SUN
              byte digit [] = { 219,130,213,199,142,79,95,194,223,207};
              byte daw [] { 2,64,128,8,4,16,1 };
              //  The main vars I'm interested in using on the clock.   the temp_den entry is for an external home assistant temperature sensor
              int c_minute=id(homeassistant_time).now().minute;
              int c_hour=id(homeassistant_time).now().hour;
              int c_temp=id(temp_den).state;
              int c_mon=id(homeassistant_time).now().month;
              int c_dom=id(homeassistant_time).now().day_of_month;
              int c_dow=id(homeassistant_time).now().day_of_week - 1;
              // The main digits,  just units & tens for most of them
              byte min1=digit[c_minute % 10];
              byte min2=digit[c_minute / 10];
              byte hour1=digit[c_hour % 10];
              byte hour2=digit[c_hour / 10];
              byte temp1=digit[c_temp % 10];
              byte temp2=digit[c_temp / 10];  
              // for the day field  bitwise OR with 0x20 to light up the M & D indicators
              byte dom1=digit[c_dom % 10] | 0x20;
              byte dom2=digit[c_dom / 10] | 0x20;
              // Hack for day of week,  lights all days up in white apart from the current day in blue
              byte day1=0;
              byte day2=0;
              for (int a=0;a<7;a++) { if (a==c_dow) { day1=day1 | daw[a]; }  else { day2=day2 | daw[a]; } };
              // hack to include the leading 1 on the month section from the right group.  starts with 4 to include the degress C symbol
              byte dots=4;
              byte mon1=digit[c_mon % 10] & 0xE7;
              dots=dots | (digit[c_mon % 10] & 0x18);
              if (c_mon>9) { mon1=mon1 | 0x18; };
              // add the clock separator dots every other second
              if ((id(homeassistant_time).now().second % 2) ==1) { dots=dots+3; }
              // Send all the I2C commands
              id(i2cdev).write_byte(0x10, id(bright_led).state);  // Screen Brightness
              id(i2cdev).write_byte(0x11, 0x0f);  // Not sure
              id(i2cdev).write_bytes(0x00, { mon1, dom1, dom2, min1, min2, min2, day1, day2, min1, hour2, dots , hour2, hour1, hour1, temp2, temp1 });  // The main data
              id(i2cdev).write_byte(0x12, 0x03);  // Not sure,  refresh display output ?

luckily the bytes do seem to follow a fairly simple format.  the bytes min1,min2,hour1,hour2  (the main numeric digits mainly)  all are a single byte that encode the bits of the 2 segment,  the digit array at the top contains the values for digits 0-9

the main oddities are the month format where for some reason the 2nd digit doesn't have the 2 left side segments with the 2nd digit and instead contain the 2 segments for the leading 1.  The 2 left segments of the 2nd digit are coded in the 11th byte which also has the following controls

    Byte 11
    Bit 0  - Clock Separator dot  TOP
    Bit 1  - Clock Separator dot  BOTTOM
    Bit 2  - degrees C symbol next to temperature
    Bit 3  - top left  segment of month digit 2
    Bit 4  - bottom lefrt segment of month digit 2
    Bit 5  - degrees F symbol next to temperature
    Bit 6  - PM indicator
    Bit 7  - DST indicator

The day bytes use bit 5 (0x20) to control the D & M symbols

Bytes 7 & 8  control mainly the Days of the week indicator.  Byte 7 controls the coloured LEDs  Byte 8 controls the white LEDs. The DOW array in the code is encoded to select the relevant DAY based on 0-7 from the ESPHome day_of_week variable. 

   bit 0  - SAT
   bit 1  - SUN
   bit 2  - THU
   bit 3  - WED
   bit 4  - FRI
   bit 5  - AL1 indicator on byte 7 & AL2 indicator on byte 8
   bit 6  - MON
   bit 7  - TUE


NOT INVESTIGATED YET
--------------------

    As this is just splitting the microprocessor from the LED driver the on board functions of the clock are continuing to work behind the scenes. I believe the following parts are used directly by this microprocessor so are unavailable in home assistant

        a) Microphone   (Not exactly sure what this is used for,  I saw mention of voice control but no idea how this works).   Detects loud noise/clapping to trigger the display when run from battery.   see Q6/Q7 & processor
        b) Buzzer for alarm.    One side connected direct to VCC,  other side to microprocessor pin 11.  Driven by PWN.  I replaced with a normal buzzer which just makes a noise when enabled.
        c) Temperature sensor  (this appears to be R23 in the squared off section within the hours digits - See pin 2 of processor
        d) Light sensor  PH1 just under the temperature that looks like a blacked out LED - See pin 1 of processor
        e) Remote pads   just to the right of the light sensor,  looks like the un-labled pads to the left need to be populated.  probably just more 0 ohm resistors??  connects to pin 12.
        f) Buttons  see below
        g) The microprocessor.   I suspect one of the standard cheap STC 8081 chinese microcontrollers that seem to be in everything these days.  UPDATE See below

    Q4/Q5/Q6/Q7  - at the moment I've no idea what these are used for.  Possibly used by the LED driver??
      Q4/Q5  control VCC into the LED driver.  controlled by pin 8 on the processor
      Q6/Q7  seem to be used an a primitive amp for the microphone into pin 23 on the microphone. 

Processor pins
--------------

 1.  Light sensor (analog?   VCC->lightsensor->signal->R7/1K->pin1 ->R8->GND
 2.  Temp sensor (analog)    VCC->PTC-> R5 ->pin2  + R5->R6->GND 
 3.  Programming C pad
 4.  Programming D pad
 5.  I2C to led driver
 6.  I2C to led driver
 7.  not connected?
 8.  Power enable for LED driver  ( drives Q4/Q5 circuit)
 9.  GND
10.  5v
11.  Buzzer
12.  IR.  Note resistors to the IR receiver not populated

13.  not connected
14.  clock xtal
15.  clock xtal
16.  not connected
17.  not connected
18.  not connected
19.  not connected
20.  not connected
21.  not connected
22.  Plugged in signal ( connected between R1 & R2)
23.  Microphone  (outputs from Q6 & Q7 circuit)
24.  Button  (analog in)

Buttons
--------
 VCC   ->   R9/10k -> ALARM button -> pin 20
 VCC   ->   R12/47K -> MINUS button -> pin 20
 VCC   ->   R11/330K  -> PLUS button -> pin 20
 VCC   ->   R10/150K  -> SET button  -> pin 20
      pin 20 connected via R13/47k to GND

Voltages (from online calculator)

AL = 4.123v
-  = 2.5v
+  = 0.6v
SET= 1.69v

changing R13 to a 15K should give the following suitable for ESP32

AL = 3v
-  = 1.21v
+  = .215v
SET= .455v

only issue with the above is powered from a USB adapter it's still not a clean 5v feed, even just flashing the time separator dots between HH &MM appears to cause fluctuations/flicker occasionally
