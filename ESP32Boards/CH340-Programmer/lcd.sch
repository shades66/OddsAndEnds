EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR0131
U 1 1 5F573509
P 2950 2750
F 0 "#PWR0131" H 2950 2500 50  0001 C CNN
F 1 "GND" H 2955 2577 50  0000 C CNN
F 2 "" H 2950 2750 50  0001 C CNN
F 3 "" H 2950 2750 50  0001 C CNN
	1    2950 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 1500 3500 850 
Wire Wire Line
	3600 1600 3600 850 
Text Label 3500 1300 1    50   ~ 0
ESP_RXD
Text Label 3600 1300 1    50   ~ 0
ESP_TXD
$Comp
L Device:LED D6
U 1 1 5F61D31C
P 3900 1150
F 0 "D6" H 3893 1366 50  0000 C CNN
F 1 "LED" H 3893 1275 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3900 1150 50  0001 C CNN
F 3 "~" H 3900 1150 50  0001 C CNN
	1    3900 1150
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 5F6ACB57
P 4850 1300
F 0 "R10" V 4643 1300 50  0000 C CNN
F 1 "10k" V 4734 1300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4780 1300 50  0001 C CNN
F 3 "~" H 4850 1300 50  0001 C CNN
	1    4850 1300
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R11
U 1 1 5F6ACE5A
P 4850 1800
F 0 "R11" V 4643 1800 50  0000 C CNN
F 1 "10k" V 4734 1800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 4780 1800 50  0001 C CNN
F 3 "~" H 4850 1800 50  0001 C CNN
	1    4850 1800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5350 1100 6250 1100
Wire Wire Line
	5350 1600 6250 1600
Text Label 5750 1100 0    50   ~ 0
ESP_EN
Text Label 5750 1600 0    50   ~ 0
BOOT
Text Notes 7700 7300 0    50   ~ 0
MiniESP32-V3\n
Text Notes 8150 7650 0    50   ~ 0
V0 13/03/2020  V1 21/07  V2 03/08   V3 12/09
Text Notes 10650 7650 0    50   ~ 0
V3
$Comp
L Interface_USB:CH340G U5
U 1 1 5F3C7EC9
P 2950 1900
F 0 "U5" H 2950 1211 50  0000 C CNN
F 1 "CH340G" H 2950 1120 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 3000 1350 50  0001 L CNN
F 3 "http://www.datasheet5.com/pdf-local-2195953" H 2600 2700 50  0001 C CNN
	1    2950 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1500 3500 1500
Wire Wire Line
	3350 1600 3600 1600
Wire Wire Line
	2950 2500 2950 2750
Wire Wire Line
	2150 1800 2550 1800
$Comp
L Device:LED D7
U 1 1 5F56E355
P 3750 1150
F 0 "D7" H 3743 1366 50  0000 C CNN
F 1 "LED" H 3743 1275 50  0000 C CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3750 1150 50  0001 C CNN
F 3 "~" H 3750 1150 50  0001 C CNN
	1    3750 1150
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 5F56E72A
P 3900 1550
F 0 "R13" V 3693 1550 50  0000 C CNN
F 1 "220r" V 3784 1550 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3830 1550 50  0001 C CNN
F 3 "~" H 3900 1550 50  0001 C CNN
	1    3900 1550
	-1   0    0    1   
$EndComp
$Comp
L Device:R R14
U 1 1 5F56EDAC
P 3750 1550
F 0 "R14" V 3543 1550 50  0000 C CNN
F 1 "220r" V 3634 1550 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3680 1550 50  0001 C CNN
F 3 "~" H 3750 1550 50  0001 C CNN
	1    3750 1550
	-1   0    0    1   
$EndComp
Wire Wire Line
	3900 1700 3900 1900
Connection ~ 3500 1500
Wire Wire Line
	3750 1700 3750 1850
Connection ~ 3600 1600
Wire Wire Line
	3900 1400 3900 1300
Wire Wire Line
	3750 1300 3750 1400
$Comp
L power:+3.3V #PWR0139
U 1 1 5F5DA9AB
P 2950 950
F 0 "#PWR0139" H 2950 800 50  0001 C CNN
F 1 "+3.3V" H 2965 1123 50  0000 C CNN
F 2 "" H 2950 950 50  0001 C CNN
F 3 "" H 2950 950 50  0001 C CNN
	1    2950 950 
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0140
U 1 1 5F5DB570
P 3800 850
F 0 "#PWR0140" H 3800 700 50  0001 C CNN
F 1 "+3.3V" H 3815 1023 50  0000 C CNN
F 2 "" H 3800 850 50  0001 C CNN
F 3 "" H 3800 850 50  0001 C CNN
	1    3800 850 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 850  3900 850 
Wire Wire Line
	3900 850  3900 1000
Wire Wire Line
	3800 850  3750 850 
Wire Wire Line
	3750 850  3750 1000
Connection ~ 3800 850 
$Comp
L Device:C C15
U 1 1 5F630245
P 2750 1050
F 0 "C15" V 3002 1050 50  0000 C CNN
F 1 "1uF" V 2911 1050 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2788 900 50  0001 C CNN
F 3 "~" H 2750 1050 50  0001 C CNN
	1    2750 1050
	-1   0    0    1   
$EndComp
Wire Wire Line
	2850 1300 2850 1200
Wire Wire Line
	2850 1200 2750 1200
Wire Wire Line
	2850 1200 2950 1200
Wire Wire Line
	2950 1200 2950 950 
Connection ~ 2850 1200
Wire Wire Line
	2950 1300 2950 1200
Connection ~ 2950 1200
Wire Wire Line
	3750 1850 3500 1850
Wire Wire Line
	3500 1850 3500 1500
Wire Wire Line
	3900 1900 3600 1900
Wire Wire Line
	3600 1900 3600 1600
Wire Wire Line
	3350 2200 3700 2200
Wire Wire Line
	3350 2300 3700 2300
Text Label 3400 2200 0    50   ~ 0
FT_DTR
Text Label 3400 2300 0    50   ~ 0
FT_RTS
Wire Wire Line
	5350 1500 4700 1500
Wire Wire Line
	4700 1500 4700 1800
Wire Wire Line
	5350 2000 4650 2000
Wire Wire Line
	4650 2000 4650 1300
Wire Wire Line
	4650 1300 4700 1300
Wire Wire Line
	4650 1300 4350 1300
Connection ~ 4650 1300
Wire Wire Line
	4700 1800 4350 1800
Connection ~ 4700 1800
Text Label 4350 1300 0    50   ~ 0
FT_DTR
Text Label 4350 1800 0    50   ~ 0
FT_RTS
Text Notes 4250 750  0    118  ~ 0
AUTO Programmer
Text Notes 6000 750  0    118  ~ 0
Decoupling Caps
Wire Wire Line
	5000 1300 5050 1300
Wire Wire Line
	5000 1800 5050 1800
$Comp
L power:GND #PWR0107
U 1 1 5F810BEA
P 2750 850
F 0 "#PWR0107" H 2750 600 50  0001 C CNN
F 1 "GND" H 2755 677 50  0000 C CNN
F 2 "" H 2750 850 50  0001 C CNN
F 3 "" H 2750 850 50  0001 C CNN
	1    2750 850 
	-1   0    0    1   
$EndComp
Wire Wire Line
	2750 900  2750 850 
$Comp
L power:VBUS #PWR0101
U 1 1 606AFC00
P 1900 2850
F 0 "#PWR0101" H 1900 2700 50  0001 C CNN
F 1 "VBUS" H 1915 3023 50  0000 C CNN
F 2 "" H 1900 2850 50  0001 C CNN
F 3 "" H 1900 2850 50  0001 C CNN
	1    1900 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2850 1900 2850
Wire Wire Line
	2200 2950 2100 2950
$Comp
L Device:C C3
U 1 1 60B62259
P 7600 1300
F 0 "C3" V 7852 1300 50  0000 C CNN
F 1 "100pf" V 7761 1300 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7638 1150 50  0001 C CNN
F 3 "~" H 7600 1300 50  0001 C CNN
	1    7600 1300
	-1   0    0    1   
$EndComp
$Comp
L power:VBUS #PWR0147
U 1 1 60B625B3
P 7600 950
F 0 "#PWR0147" H 7600 800 50  0001 C CNN
F 1 "VBUS" H 7615 1123 50  0000 C CNN
F 2 "" H 7600 950 50  0001 C CNN
F 3 "" H 7600 950 50  0001 C CNN
	1    7600 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0148
U 1 1 60B62D35
P 7600 1600
F 0 "#PWR0148" H 7600 1350 50  0001 C CNN
F 1 "GND" H 7605 1427 50  0000 C CNN
F 2 "" H 7600 1600 50  0001 C CNN
F 3 "" H 7600 1600 50  0001 C CNN
	1    7600 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 60B6306D
P 7800 1300
F 0 "C6" V 8052 1300 50  0000 C CNN
F 1 "10uF" V 7961 1300 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 7838 1150 50  0001 C CNN
F 3 "~" H 7800 1300 50  0001 C CNN
	1    7800 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	7600 1600 7600 1450
Wire Wire Line
	7600 1450 7800 1450
Connection ~ 7600 1450
Wire Wire Line
	7800 1150 7600 1150
Wire Wire Line
	7600 1150 7600 950 
Connection ~ 7600 1150
$Comp
L Regulator_Linear:AP2112K-3.3 U2
U 1 1 608F3975
P 2650 3550
F 0 "U2" H 2650 3892 50  0000 C CNN
F 1 "AP2112K-3.3" H 2650 3801 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 2650 3875 50  0001 C CNN
F 3 "https://www.diodes.com/assets/Datasheets/AP2112.pdf" H 2650 3650 50  0001 C CNN
	1    2650 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 608F5042
P 2100 3600
F 0 "C2" V 2352 3600 50  0000 C CNN
F 1 "1uF" V 2261 3600 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 2138 3450 50  0001 C CNN
F 3 "~" H 2100 3600 50  0001 C CNN
	1    2100 3600
	-1   0    0    1   
$EndComp
$Comp
L Device:C C5
U 1 1 608F59EC
P 3200 3600
F 0 "C5" V 3452 3600 50  0000 C CNN
F 1 "1uF" V 3361 3600 50  0000 C CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 3238 3450 50  0001 C CNN
F 3 "~" H 3200 3600 50  0001 C CNN
	1    3200 3600
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR0121
U 1 1 608F5BC0
P 2650 4000
F 0 "#PWR0121" H 2650 3750 50  0001 C CNN
F 1 "GND" H 2655 3827 50  0000 C CNN
F 2 "" H 2650 4000 50  0001 C CNN
F 3 "" H 2650 4000 50  0001 C CNN
	1    2650 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4000 2100 4000
Wire Wire Line
	2100 4000 2100 3750
Wire Wire Line
	2650 4000 3200 4000
Wire Wire Line
	3200 4000 3200 3750
Connection ~ 2650 4000
Wire Wire Line
	2650 3850 2650 4000
Wire Wire Line
	2100 3450 2350 3450
Wire Wire Line
	2950 3450 3200 3450
$Comp
L power:+3.3V #PWR0134
U 1 1 6094F7DB
P 3200 3350
F 0 "#PWR0134" H 3200 3200 50  0001 C CNN
F 1 "+3.3V" H 3215 3523 50  0000 C CNN
F 2 "" H 3200 3350 50  0001 C CNN
F 3 "" H 3200 3350 50  0001 C CNN
	1    3200 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 3450 2100 2950
Connection ~ 2100 3450
Wire Wire Line
	3200 3450 3200 3350
Connection ~ 3200 3450
Wire Wire Line
	2350 3550 2350 3450
Connection ~ 2350 3450
Wire Wire Line
	2150 1700 2150 1800
Wire Wire Line
	2050 1900 2550 1900
Text Notes 1600 650  0    118  ~ 0
USB Interface
Wire Wire Line
	2200 2850 2200 2950
Text Label 2250 1800 0    118  ~ 0
D+
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 635A913C
P 4350 2750
F 0 "J2" H 4430 2742 50  0000 L CNN
F 1 "Conn_01x04" H 4430 2651 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 4350 2750 50  0001 C CNN
F 3 "~" H 4350 2750 50  0001 C CNN
	1    4350 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 2650 4150 2650
Wire Wire Line
	3750 2750 4150 2750
Wire Wire Line
	3750 2850 4150 2850
Wire Wire Line
	3750 2950 4150 2950
Text Label 3800 2650 0    59   ~ 0
VBUS
Text Label 3800 2750 0    59   ~ 0
D+
Text Label 3800 2850 0    59   ~ 0
D-
Text Label 3800 2950 0    59   ~ 0
GND
Text Label 2300 1900 0    59   ~ 0
D-
$Comp
L Connector_Generic:Conn_01x07 J4
U 1 1 635D8B69
P 8550 2800
F 0 "J4" H 8630 2842 50  0000 L CNN
F 1 "Conn_01x07" H 8630 2751 50  0000 L CNN
F 2 "Connector_PinHeader_2.00mm:PinHeader_1x07_P2.00mm_Vertical" H 8550 2800 50  0001 C CNN
F 3 "~" H 8550 2800 50  0001 C CNN
	1    8550 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2500 7600 2500
Wire Wire Line
	8350 2700 7600 2700
Wire Wire Line
	8350 2800 7600 2800
Wire Wire Line
	8350 2900 7600 2900
Wire Wire Line
	8350 3000 7600 3000
Wire Wire Line
	8350 3100 7600 3100
Text Label 7700 3100 0    59   ~ 0
GND
Text Label 7700 2500 0    59   ~ 0
VBUS
Text Label 7700 2600 0    59   ~ 0
+3.3V
Text Label 7700 2700 0    59   ~ 0
ESP_RXD
Text Label 7700 2800 0    59   ~ 0
ESP_TXD
Text Label 7700 2900 0    59   ~ 0
BOOT
Text Label 7700 3000 0    59   ~ 0
ESP_EN
$Comp
L power:+3.3V #PWR0102
U 1 1 6358ECF7
P 7550 2600
F 0 "#PWR0102" H 7550 2450 50  0001 C CNN
F 1 "+3.3V" H 7565 2773 50  0000 C CNN
F 2 "" H 7550 2600 50  0001 C CNN
F 3 "" H 7550 2600 50  0001 C CNN
	1    7550 2600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7550 2600 8350 2600
$Comp
L lcd-rescue:S8050-Transistor_BJT Q2
U 1 1 5F59F447
P 5250 1800
F 0 "Q2" H 5441 1846 50  0000 L CNN
F 1 "S8050-Transistor_BJT" H 5441 1755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5450 1725 50  0001 L CIN
F 3 "" H 5250 1800 50  0001 L CNN
	1    5250 1800
	1    0    0    -1  
$EndComp
$Comp
L lcd-rescue:S8050-Transistor_BJT Q1
U 1 1 5F59E78A
P 5250 1300
F 0 "Q1" H 5441 1346 50  0000 L CNN
F 1 "S8050-Transistor_BJT" H 5441 1255 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5450 1225 50  0001 L CIN
F 3 "" H 5250 1300 50  0001 L CNN
	1    5250 1300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
