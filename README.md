# OddsAndEnds
Just odds and ends I've saved for a rainy day


markisol.h  - ESPHome library to allow use of BOFU  BF-301  controlled blinds via RF transmitter

Philips-LivingColours-GEN2.jpeg  - PCB from an old Philips LivingColours lamp which we have long since lost the remote for.  Modified to work as part of my ESPHome setup.   See key on image for the locations of the various control pins,  I mounted a M5Stack Pico over the location the original CPU sat and ran wires to the 4 gpios for RED/GREEN/BLUE & Enable (as far as I can tell enables the powersupply section that feeds the LED's).  I did try using the 3v feed that fed the microprocessor but it was not enough for the ESP32 to powerup.  instead I used a mini buck converter with the inputs from a capacitor connected to the Power in port (18 Volts!!) which provided a 5v feed for the pico.

LivingColours.yaml  - ESPHome config for the above circuit.  See pins defined for the connections I made on the PCB.  This setup is the basic rgb light config with two extras for on_turn_on/on_turn_off which switch the enable pin high/low.

