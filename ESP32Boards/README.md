
Some of the boards I've been making for use a base boards for various Home Assistant & Other odds and ends

Folders are

CH340-Programmer  -  Board that contains the pins that match up with the pins on the V1.1 & V2 boards for programming
USB-C-Board  - Small board for holding a USB C SMD connector / related 5.1k resistors & header for 4 pins to other boards like the CH340 programmer & V1.1 board
V1  - ESP32 WROVER based board includes on board CH340 chip for programming ,   
         pins for connecting LED strips & badly aligned headers for other external devices  (sensors, transeivers etc)
V1.1 - ESP32 WROVER based revision of V1 to make smaller,    
         Corrected header alignments,   
         USB now via 4 pin header,  
         header for CH340 programmer or can add a CH340 & components to the bottom,  
         + 6 mini 2020 WS2812 Led's because why not...
V2 -   ESP32-S3 BASED (can use both S3-WROOM-1U & S3-WROOM-1 modules) 
        Complete re-vamp.  
        Connections now via 1.25mm JST connectors.  
          5x  4 pin  3.3v/GND/Dx/Dy format,  
          1x 4 pin  3.3v OR 5v/GND/Dx/Dy pinout (pin numbers on silkscreen),  
          1x 8 pin extra IO  3.3v/GND + 6IO - also available via 0.5mm Flex connector (compatible with corresponding connector on some TFT panels  eg https://www.aliexpress.com/item/1005003764841816.html )
          6pin 2mm header for programmer as V1.1
          1x 4pin 1.25mm  USB connection direct to S3 (via protection chip)
        Multiple power options
          1. USB Input pins   - 5v
          2. 2.54mm header (or can hold buck converter)   5v
          3. 2 pin into buck converter  5-24v
        3x3 matrix of 2020 WS2812 LED's
        2x LDO,   1 for just the ESP32 S3,  other for everything else so could be 5v if wanted (not with LIS3H though).  Can be joined so only 1 needs to be populated
        LIS3H  https://www.st.com/resource/en/datasheet/lis3dh.pdf


Files in these directories supplied with no warranty whatsoever.  They are just backups of boards I have created,  V2 has interactive BOM,  Files work in KiCad 7,   zip files supplied which is what I sent to JLCPCB to have produced.   They are single boards only, panelized within JLCPCB web interface.
