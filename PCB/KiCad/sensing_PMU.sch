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
Wire Wire Line
	4100 6500 4600 6500
Wire Wire Line
	4600 6500 4600 6600
Connection ~ 4600 6500
Text Label 4600 6900 0    10   ~ 0
GND
Wire Wire Line
	6900 1200 6500 1200
Text Label 6900 1200 0    10   ~ 0
GND
Wire Wire Line
	3600 5700 3400 5700
Wire Wire Line
	3400 5700 3000 5700
Connection ~ 3400 5700
Wire Wire Line
	4100 5500 4100 5100
Wire Wire Line
	4500 5500 4100 5500
Wire Wire Line
	4100 5500 4100 5700
Connection ~ 4100 5500
Connection ~ 4100 5700
Wire Wire Line
	5100 5100 5100 5500
Wire Wire Line
	7150 3300 7150 3100
Text Label 6650 3300 0    70   ~ 0
VBUCK
Text Label 4150 1700 0    70   ~ 0
VBUCK
Wire Wire Line
	2200 1300 2300 1300
Text Label 2300 1300 0    70   ~ 0
VBUCK
Wire Wire Line
	3200 1300 3300 1300
Text Label 3300 1300 0    70   ~ 0
VBUCK
Wire Wire Line
	2200 1400 2300 1400
Text Label 2300 1400 0    70   ~ 0
SELMPP0
Text Label 3950 3300 0    70   ~ 0
SELMPP0
Wire Wire Line
	3200 1400 3300 1400
Text Label 3300 1400 0    70   ~ 0
SELMPP1
Text Label 3950 3200 0    70   ~ 0
SELMPP1
Wire Wire Line
	4500 1300 4500 1200
Text Label 3950 1200 0    70   ~ 0
VSOLAR_MEAS
Wire Wire Line
	6500 1300 6600 1300
Text Label 6600 1300 0    70   ~ 0
VBATT_MEAS
Text Label 9000 950  0    70   ~ 0
VBATT
Wire Wire Line
	6500 1700 6600 1700
Text Label 6600 1700 0    70   ~ 0
HVOUT
Wire Wire Line
	10350 2600 10350 2500
Text Label 3400 5000 0    70   ~ 0
VDD
Text Label 4100 6100 0    70   ~ 0
VDD
Wire Wire Line
	6500 2400 8300 2400
Text Label 6600 2400 0    70   ~ 0
BOOST
Wire Wire Line
	7800 2600 7600 2600
Wire Wire Line
	7600 2600 7600 2800
$Comp
L Device:C_Small C1
U 1 1 3AA092C6
P 3700 5700
F 0 "C1" H 3760 5715 59  0000 L BNN
F 1 "3.3u" H 3760 5515 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3700 5700 50  0001 C CNN
F 3 "" H 3700 5700 50  0001 C CNN
	1    3700 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C3
U 1 1 47DDFE4D
P 4600 6700
F 0 "C3" H 4660 6715 59  0000 L BNN
F 1 "470n" H 4660 6515 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4600 6700 50  0001 C CNN
F 3 "" H 4600 6700 50  0001 C CNN
	1    4600 6700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C2
U 1 1 BA97753D
P 4600 5500
F 0 "C2" H 4660 5515 59  0000 L BNN
F 1 "2p" H 4660 5315 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4600 5500 50  0001 C CNN
F 3 "" H 4600 5500 50  0001 C CNN
	1    4600 5500
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R1
U 1 1 D2E1F5ED
P 3400 5300
F 0 "R1" H 3250 5359 59  0000 L BNN
F 1 "2.37k" H 3100 5150 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 3400 5300 50  0001 C CNN
F 3 "" H 3400 5300 50  0001 C CNN
	1    3400 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R2
U 1 1 476B8B7C
P 4700 5100
F 0 "R2" H 4550 5159 59  0000 L BNN
F 1 "3.83M" H 4400 4950 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 4700 5100 50  0001 C CNN
F 3 "" H 4700 5100 50  0001 C CNN
	1    4700 5100
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R4
U 1 1 459BFFE0
P 4100 6800
F 0 "R4" H 3950 6859 59  0000 L BNN
F 1 "150k" H 3850 6650 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 4100 6800 50  0001 C CNN
F 3 "" H 4100 6800 50  0001 C CNN
	1    4100 6800
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY01
U 1 1 E46721A6
P 4100 7100
F 0 "#SUPPLY01" H 4100 7100 50  0001 C CNN
F 1 "GND" H 4025 6975 59  0000 L BNN
F 2 "" H 4100 7100 50  0001 C CNN
F 3 "" H 4100 7100 50  0001 C CNN
	1    4100 7100
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY02
U 1 1 33EFDB7C
P 4600 7100
F 0 "#SUPPLY02" H 4600 7100 50  0001 C CNN
F 1 "GND" H 4525 6975 59  0000 L BNN
F 2 "" H 4600 7100 50  0001 C CNN
F 3 "" H 4600 7100 50  0001 C CNN
	1    4600 7100
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY05
U 1 1 FD320F9F
P 5100 6200
F 0 "#SUPPLY05" H 5100 6200 50  0001 C CNN
F 1 "GND" H 5025 6075 59  0000 L BNN
F 2 "" H 5100 6200 50  0001 C CNN
F 3 "" H 5100 6200 50  0001 C CNN
	1    5100 6200
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY06
U 1 1 C21E2EB3
P 3000 6200
F 0 "#SUPPLY06" H 3000 6200 50  0001 C CNN
F 1 "GND" H 2925 6075 59  0000 L BNN
F 2 "" H 3000 6200 50  0001 C CNN
F 3 "" H 3000 6200 50  0001 C CNN
	1    3000 6200
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY07
U 1 1 70B0FDB1
P 5500 4200
F 0 "#SUPPLY07" H 5500 4200 50  0001 C CNN
F 1 "GND" H 5425 4075 59  0000 L BNN
F 2 "" H 5500 4200 50  0001 C CNN
F 3 "" H 5500 4200 50  0001 C CNN
	1    5500 4200
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY08
U 1 1 CC52D7E0
P 8950 1950
F 0 "#SUPPLY08" H 8950 1950 50  0001 C CNN
F 1 "GND" H 8875 1825 59  0000 L BNN
F 2 "" H 8950 1950 50  0001 C CNN
F 3 "" H 8950 1950 50  0001 C CNN
	1    8950 1950
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY010
U 1 1 AC3081B0
P 2300 1500
F 0 "#SUPPLY010" H 2300 1500 50  0001 C CNN
F 1 "GND" V 2325 1175 59  0000 L BNN
F 2 "" H 2300 1500 50  0001 C CNN
F 3 "" H 2300 1500 50  0001 C CNN
	1    2300 1500
	0    -1   -1   0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY011
U 1 1 EFE06A32
P 3300 1500
F 0 "#SUPPLY011" H 3300 1500 50  0001 C CNN
F 1 "GND" V 3325 1175 59  0000 L BNN
F 2 "" H 3300 1500 50  0001 C CNN
F 3 "" H 3300 1500 50  0001 C CNN
	1    3300 1500
	0    -1   -1   0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY014
U 1 1 847A6B8B
P 4400 2600
F 0 "#SUPPLY014" H 4400 2600 50  0001 C CNN
F 1 "GND" H 4325 2475 59  0000 L BNN
F 2 "" H 4400 2600 50  0001 C CNN
F 3 "" H 4400 2600 50  0001 C CNN
	1    4400 2600
	0    1    1    0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY015
U 1 1 6EC63A1B
P 4400 1800
F 0 "#SUPPLY015" H 4400 1800 50  0001 C CNN
F 1 "GND" H 4325 1675 59  0000 L BNN
F 2 "" H 4400 1800 50  0001 C CNN
F 3 "" H 4400 1800 50  0001 C CNN
	1    4400 1800
	0    1    1    0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY016
U 1 1 268EB7DE
P 4400 2100
F 0 "#SUPPLY016" H 4400 2100 50  0001 C CNN
F 1 "GND" H 4325 1975 59  0000 L BNN
F 2 "" H 4400 2100 50  0001 C CNN
F 3 "" H 4400 2100 50  0001 C CNN
	1    4400 2100
	0    1    1    0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY017
U 1 1 65B39815
P 4400 2200
F 0 "#SUPPLY017" H 4400 2200 50  0001 C CNN
F 1 "GND" H 4325 2075 59  0000 L BNN
F 2 "" H 4400 2200 50  0001 C CNN
F 3 "" H 4400 2200 50  0001 C CNN
	1    4400 2200
	0    1    1    0   
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY018
U 1 1 F59CD171
P 7000 1200
F 0 "#SUPPLY018" H 7000 1200 50  0001 C CNN
F 1 "GND" V 7025 975 59  0000 C BNN
F 2 "" H 7000 1200 50  0001 C CNN
F 3 "" H 7000 1200 50  0001 C CNN
	1    7000 1200
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small CHV1
U 1 1 5765A2B7
P 10350 2700
F 0 "CHV1" H 10410 2715 59  0000 L BNN
F 1 "10u" H 10410 2515 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10350 2700 50  0001 C CNN
F 3 "" H 10350 2700 50  0001 C CNN
	1    10350 2700
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY020
U 1 1 11576E5E
P 10350 2900
F 0 "#SUPPLY020" H 10350 2900 50  0001 C CNN
F 1 "GND" H 10275 2775 59  0000 L BNN
F 2 "" H 10350 2900 50  0001 C CNN
F 3 "" H 10350 2900 50  0001 C CNN
	1    10350 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small CBOOST1
U 1 1 9AB9D110
P 8300 2500
F 0 "CBOOST1" H 8360 2515 59  0000 L BNN
F 1 "22u" H 8360 2315 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 8300 2500 50  0001 C CNN
F 3 "" H 8300 2500 50  0001 C CNN
	1    8300 2500
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY021
U 1 1 BB85E6C7
P 8300 2700
F 0 "#SUPPLY021" H 8300 2700 50  0001 C CNN
F 1 "GND" H 8225 2575 59  0000 L BNN
F 2 "" H 8300 2700 50  0001 C CNN
F 3 "" H 8300 2700 50  0001 C CNN
	1    8300 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small CSRC1
U 1 1 705CDE81
P 7800 2700
F 0 "CSRC1" H 7860 2715 59  0000 L BNN
F 1 "10u" H 7860 2515 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7800 2700 50  0001 C CNN
F 3 "" H 7800 2700 50  0001 C CNN
	1    7800 2700
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY022
U 1 1 75100347
P 7800 2900
F 0 "#SUPPLY022" H 7800 2900 50  0001 C CNN
F 1 "GND" H 7725 2775 59  0000 L BNN
F 2 "" H 7800 2900 50  0001 C CNN
F 3 "" H 7800 2900 50  0001 C CNN
	1    7800 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small CBUCK1
U 1 1 0CD3195E
P 7150 3400
F 0 "CBUCK1" H 7210 3415 59  0000 L BNN
F 1 "10u" H 7210 3215 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7150 3400 50  0001 C CNN
F 3 "" H 7150 3400 50  0001 C CNN
	1    7150 3400
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY023
U 1 1 B94ED314
P 7150 3600
F 0 "#SUPPLY023" H 7150 3600 50  0001 C CNN
F 1 "GND" H 7075 3475 59  0000 L BNN
F 2 "" H 7150 3600 50  0001 C CNN
F 3 "" H 7150 3600 50  0001 C CNN
	1    7150 3600
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:JP2E-microphone_kicad-eagle-import-sensing_PMU-rescue JP2
U 1 1 FA93C76E
P 3100 1400
F 0 "JP2" V 2950 1400 59  0000 L BNN
F 1 "MPPT1" V 3325 1400 59  0000 L BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 3100 1400 50  0001 C CNN
F 3 "" H 3100 1400 50  0001 C CNN
	1    3100 1400
	0    -1   -1   0   
$EndComp
$Comp
L sensing_PMU-rescue:JP2E-microphone_kicad-eagle-import-sensing_PMU-rescue JP1
U 1 1 2F430EF2
P 2100 1400
F 0 "JP1" V 1950 1400 59  0000 L BNN
F 1 "MPPT0" V 2325 1400 59  0000 L BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 2100 1400 50  0001 C CNN
F 3 "" H 2100 1400 50  0001 C CNN
	1    2100 1400
	0    -1   -1   0   
$EndComp
Text Label 10350 2500 0    70   ~ 0
HVOUT
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY0101
U 1 1 5E5E0359
P 10350 1900
F 0 "#SUPPLY0101" H 10350 1900 50  0001 C CNN
F 1 "GND" H 10275 1775 59  0000 L BNN
F 2 "" H 10350 1900 50  0001 C CNN
F 3 "" H 10350 1900 50  0001 C CNN
	1    10350 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US RBATT1
U 1 1 5E5E035F
P 10350 1600
F 0 "RBATT1" H 10200 1659 59  0000 L BNN
F 1 "475k" H 10100 1450 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 10350 1600 50  0001 C CNN
F 3 "" H 10350 1600 50  0001 C CNN
	1    10350 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US RBATT2
U 1 1 5E5E0365
P 10350 1200
F 0 "RBATT2" H 10200 1259 59  0000 L BNN
F 1 "475k" H 10100 1100 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 10350 1200 50  0001 C CNN
F 3 "" H 10350 1200 50  0001 C CNN
	1    10350 1200
	1    0    0    -1  
$EndComp
Text Label 10350 1000 0    70   ~ 0
VBATT
Text Label 10450 1400 0    70   ~ 0
VBATT_ADC
Wire Wire Line
	10350 1400 10450 1400
Text Label 9900 5250 0    70   ~ 0
VBATT_ADC
Text Label 5100 5100 0    70   ~ 0
V_mic_ADC
Text Label 5100 5100 0    70   ~ 0
V_mic_ADC
Text Label 9900 5350 0    70   ~ 0
V_mic_ADC
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY0102
U 1 1 5E621938
P 10300 5000
F 0 "#SUPPLY0102" H 10300 5000 50  0001 C CNN
F 1 "GND" H 10225 4875 59  0000 L BNN
F 2 "" H 10300 5000 50  0001 C CNN
F 3 "" H 10300 5000 50  0001 C CNN
	1    10300 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10300 4900 10200 4900
Wire Wire Line
	10200 4900 10200 5050
Wire Wire Line
	3950 3200 4500 3200
Wire Wire Line
	3950 3300 4500 3300
Wire Wire Line
	4150 1700 4500 1700
Text Label 1450 2300 0    70   ~ 0
VSOLAR
Text Label 6600 1800 0    70   ~ 0
FB_HV
Wire Wire Line
	6600 1800 6500 1800
Wire Wire Line
	9800 2550 9900 2550
Text Label 9900 2550 0    70   ~ 0
HVOUT
Wire Wire Line
	9800 2650 9900 2650
Text Label 9900 2650 0    70   ~ 0
VDD
Wire Wire Line
	3800 5700 4100 5700
Wire Wire Line
	3400 5400 3400 5700
Wire Wire Line
	3400 5000 3400 5200
Wire Wire Line
	4100 5100 4600 5100
Wire Wire Line
	4800 5100 5100 5100
Wire Wire Line
	4700 5500 5100 5500
Wire Wire Line
	4600 6800 4600 7000
Wire Wire Line
	4100 7000 4100 6900
Wire Wire Line
	10350 1000 10350 1100
Wire Wire Line
	10350 1300 10350 1400
Connection ~ 10350 1400
Wire Wire Line
	10350 1400 10350 1500
Wire Wire Line
	10350 1700 10350 1800
Text Label 8950 5150 2    70   ~ 0
VDD
Text Label 8950 5050 2    70   ~ 0
VDD
Text Label 8950 4950 2    70   ~ 0
VDD
Text Label 8950 4850 2    70   ~ 0
VDD
$Comp
L Connector:Conn_01x02_Male J4
U 1 1 5E7AE7A4
P 7400 1400
F 0 "J4" H 7508 1581 50  0000 C CNN
F 1 "BATT" H 7508 1490 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 7400 1400 50  0001 C CNN
F 3 "~" H 7400 1400 50  0001 C CNN
	1    7400 1400
	1    0    0    -1  
$EndComp
Text Label 7600 1400 0    70   ~ 0
VBATT_MEAS
Text Label 7600 1500 0    70   ~ 0
VBATT
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 5E7B6705
P 1250 2200
F 0 "J3" H 1358 2381 50  0000 C CNN
F 1 "SOLAR" H 1358 2290 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1250 2200 50  0001 C CNN
F 3 "~" H 1250 2200 50  0001 C CNN
	1    1250 2200
	1    0    0    -1  
$EndComp
Text Label 1450 2200 0    70   ~ 0
VSOLAR_MEAS
Wire Wire Line
	3950 1200 4500 1200
Connection ~ 4500 1200
$Comp
L sensing_PMU-rescue:AEM10941-AEM10941 U1
U 1 1 5E67AD74
P 5500 2500
F 0 "U1" H 5500 4067 50  0000 C CNN
F 1 "AEM10941" H 5500 3976 50  0000 C CNN
F 2 "AEM10941:QFN28_5X5_05PITCH" H 5500 2500 50  0001 C CNN
F 3 "" H 5500 2500 50  0001 C CNN
	1    5500 2500
	1    0    0    -1  
$EndComp
Text Label 3950 2800 0    50   ~ 0
VBUCK
Text Label 3950 2700 0    50   ~ 0
VBUCK
Wire Wire Line
	3950 2700 4500 2700
Wire Wire Line
	3950 2800 4500 2800
$Comp
L MAL219690102E3:MAL219690102E3 C5
U 1 1 5E8C0F85
P 9000 950
F 0 "C5" V 9404 1078 50  0000 L CNN
F 1 "MAL219690102E3" V 9495 1078 50  0000 L CNN
F 2 "SamacSys_Parts:MAL219690102E3" H 9750 1050 50  0001 L CNN
F 3 "https://www.vishay.com/docs/28409/196hvc.pdf" H 9750 950 50  0001 L CNN
F 4 "Vishay 90F Supercapacitor EDLC -20  +80% Tolerance 196 HVC Series 5.6V dc Through Hole" H 9750 850 50  0001 L CNN "Description"
F 5 "26.5" H 9750 750 50  0001 L CNN "Height"
F 6 "Vishay" H 9750 650 50  0001 L CNN "Manufacturer_Name"
F 7 "MAL219690102E3" H 9750 550 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "594-MAL219690102E3" H 9750 450 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=594-MAL219690102E3" H 9750 350 50  0001 L CNN "Mouser Price/Stock"
F 10 "8756748P" H 9750 250 50  0001 L CNN "RS Part Number"
F 11 "http://uk.rs-online.com/web/p/products/8756748P" H 9750 150 50  0001 L CNN "RS Price/Stock"
F 12 "70592241" H 9750 50  50  0001 L CNN "Allied_Number"
F 13 "https://www.alliedelec.com/bccomponents-vishay-mal219690102e3/70592241/" H 9750 -50 50  0001 L CNN "Allied Price/Stock"
	1    9000 950 
	0    1    1    0   
$EndComp
Wire Wire Line
	8900 1850 8950 1850
Connection ~ 8950 1850
Wire Wire Line
	8950 1850 9000 1850
Wire Wire Line
	4100 6200 4100 6100
Wire Wire Line
	4100 6500 4100 6700
$Comp
L Device:R_Small_US R3
U 1 1 FB45FC39
P 4100 6300
F 0 "R3" H 3950 6359 59  0000 L BNN
F 1 "150k" H 3850 6200 59  0000 L BNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 4100 6300 50  0001 C CNN
F 3 "" H 4100 6300 50  0001 C CNN
	1    4100 6300
	1    0    0    -1  
$EndComp
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY09
U 1 1 5E9010E1
P 800 3450
F 0 "#SUPPLY09" H 800 3450 50  0001 C CNN
F 1 "GND" H 725 3325 59  0000 L BNN
F 2 "" H 800 3450 50  0001 C CNN
F 3 "" H 800 3450 50  0001 C CNN
	1    800  3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  2900 800  2750
Wire Wire Line
	800  3200 800  3350
Wire Wire Line
	1750 2900 1750 2750
Wire Wire Line
	1250 2900 1250 2750
Wire Wire Line
	1250 3200 1250 3350
Wire Wire Line
	1750 3200 1750 3350
$Comp
L SM141K06L:SM141K06L SC1
U 1 1 5E935872
P 800 3100
F 0 "SC1" H 908 3196 50  0000 L CNN
F 1 "SM141K06L" H 908 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 800 3160 50  0001 C CNN
F 3 "~" V 800 3160 50  0001 C CNN
	1    800  3100
	1    0    0    -1  
$EndComp
$Comp
L SM141K06L:SM141K06L SC2
U 1 1 5E93B020
P 1250 3100
F 0 "SC2" H 1358 3196 50  0000 L CNN
F 1 "SM141K06L" H 1358 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 1250 3160 50  0001 C CNN
F 3 "~" V 1250 3160 50  0001 C CNN
	1    1250 3100
	1    0    0    -1  
$EndComp
$Comp
L SM141K06L:SM141K06L SC3
U 1 1 5E93B504
P 1750 3100
F 0 "SC3" H 1858 3196 50  0000 L CNN
F 1 "SM141K06L" H 1858 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 1750 3160 50  0001 C CNN
F 3 "~" V 1750 3160 50  0001 C CNN
	1    1750 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  2750 1250 2750
Wire Wire Line
	1250 2750 1750 2750
Connection ~ 1250 2750
Wire Wire Line
	1250 3350 1750 3350
Connection ~ 1250 3350
Wire Wire Line
	800  3350 1250 3350
Connection ~ 800  3350
Text Label 3100 2750 0    70   ~ 0
VSOLAR
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY03
U 1 1 5E8F433B
P 2150 3450
F 0 "#SUPPLY03" H 2150 3450 50  0001 C CNN
F 1 "GND" H 2075 3325 59  0000 L BNN
F 2 "" H 2150 3450 50  0001 C CNN
F 3 "" H 2150 3450 50  0001 C CNN
	1    2150 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 2900 2150 2750
Wire Wire Line
	2150 3200 2150 3350
Wire Wire Line
	3100 2900 3100 2750
Wire Wire Line
	2600 2900 2600 2750
Wire Wire Line
	2600 3200 2600 3350
Wire Wire Line
	3100 3200 3100 3350
$Comp
L SM141K06L:SM141K06L SC4
U 1 1 5E8F434B
P 2150 3100
F 0 "SC4" H 2258 3196 50  0000 L CNN
F 1 "SM141K06L" H 2258 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 2150 3160 50  0001 C CNN
F 3 "~" V 2150 3160 50  0001 C CNN
	1    2150 3100
	1    0    0    -1  
$EndComp
$Comp
L SM141K06L:SM141K06L SC5
U 1 1 5E8F4355
P 2600 3100
F 0 "SC5" H 2708 3196 50  0000 L CNN
F 1 "SM141K06L" H 2708 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 2600 3160 50  0001 C CNN
F 3 "~" V 2600 3160 50  0001 C CNN
	1    2600 3100
	1    0    0    -1  
$EndComp
$Comp
L SM141K06L:SM141K06L SC6
U 1 1 5E8F435F
P 3100 3100
F 0 "SC6" H 3208 3196 50  0000 L CNN
F 1 "SM141K06L" H 3208 3105 50  0000 L CNN
F 2 "SM141K06L:SM141K06L" V 3100 3160 50  0001 C CNN
F 3 "~" V 3100 3160 50  0001 C CNN
	1    3100 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 2750 2600 2750
Wire Wire Line
	2600 2750 3100 2750
Connection ~ 2600 2750
Wire Wire Line
	2600 3350 3100 3350
Connection ~ 2600 3350
Wire Wire Line
	2150 3350 2600 3350
Connection ~ 2150 3350
Wire Wire Line
	2150 2750 1750 2750
Connection ~ 2150 2750
Connection ~ 1750 2750
Wire Wire Line
	2150 3350 1750 3350
Connection ~ 1750 3350
$Comp
L Device:Microphone_Condenser MK1
U 1 1 5E6A1A7E
P 3000 5900
F 0 "MK1" H 3130 5946 50  0000 L CNN
F 1 "AOM-5024L-HD-R" H 3130 5855 50  0000 L CNN
F 2 "AOM-5024L-HD-R:AOM-5024L-HD-R" V 3000 6000 50  0001 C CNN
F 3 "~" V 3000 6000 50  0001 C CNN
	1    3000 5900
	1    0    0    -1  
$EndComp
$Comp
L OPA2834IDGKR:OPA2834IDGKR IC1
U 1 1 5E8C9045
P 5200 5600
F 0 "IC1" H 5800 5865 50  0000 C CNN
F 1 "OPA2834IDGKR" H 5800 5774 50  0000 C CNN
F 2 "SOP65P490X110-8N" H 6250 5700 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/opa2834.pdf" H 6250 5600 50  0001 L CNN
F 4 "High Speed Operational Amplifiers LOW POWER HIGH SPEED OP AMP" H 6250 5500 50  0001 L CNN "Description"
F 5 "1.1" H 6250 5400 50  0001 L CNN "Height"
F 6 "Texas Instruments" H 6250 5300 50  0001 L CNN "Manufacturer_Name"
F 7 "OPA2834IDGKR" H 6250 5200 50  0001 L CNN "Manufacturer_Part_Number"
F 8 "595-OPA2834IDGKR" H 6250 5100 50  0001 L CNN "Mouser Part Number"
F 9 "https://www.mouser.com/Search/Refine.aspx?Keyword=595-OPA2834IDGKR" H 6250 5000 50  0001 L CNN "Mouser Price/Stock"
F 10 "" H 6250 4900 50  0001 L CNN "RS Part Number"
F 11 "" H 6250 4800 50  0001 L CNN "RS Price/Stock"
	1    5200 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 5800 4600 6500
Wire Wire Line
	4600 5800 5200 5800
Wire Wire Line
	5200 5900 5100 5900
Wire Wire Line
	5100 5900 5100 6100
Wire Wire Line
	4100 5700 5200 5700
Wire Wire Line
	5200 5600 5100 5600
Wire Wire Line
	5100 5600 5100 5500
Connection ~ 5100 5500
Wire Wire Line
	6700 5500 6700 5400
$Comp
L sensing_PMU-rescue:GND-microphone_kicad-eagle-import-sensing_PMU-rescue #SUPPLY04
U 1 1 6DF68C43
P 6700 5600
F 0 "#SUPPLY04" H 6700 5600 50  0001 C CNN
F 1 "GND" H 6625 5475 59  0000 L BNN
F 2 "" H 6700 5600 50  0001 C CNN
F 3 "" H 6700 5600 50  0001 C CNN
	1    6700 5600
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 14094E0B
P 6700 5300
F 0 "C4" H 6760 5315 59  0000 L BNN
F 1 "100n" H 6760 5115 59  0000 L BNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6700 5300 50  0001 C CNN
F 3 "" H 6700 5300 50  0001 C CNN
	1    6700 5300
	1    0    0    -1  
$EndComp
Text Label 6400 5100 0    70   ~ 0
VDD
Connection ~ 6400 5200
Wire Wire Line
	6400 5200 6400 5600
Wire Wire Line
	6400 5200 6700 5200
Wire Wire Line
	6400 5100 6400 5200
Wire Wire Line
	7600 2800 6500 2800
$Comp
L master_thesis_tim:Master_Thesis_Tim U2
U 1 1 5E94E65A
P 10350 4550
F 0 "U2" H 9425 4475 50  0000 C CNN
F 1 "Master_Thesis_Tim" H 9425 4384 50  0000 C CNN
F 2 "Master_Thesis_Tim:Master_Thesis_Tim" H 10350 4550 50  0001 C CNN
F 3 "" H 10350 4550 50  0001 C CNN
	1    10350 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 5050 10200 5050
Wire Wire Line
	4100 6500 4100 6400
Connection ~ 4100 6500
$Comp
L sensing_PMU-rescue:JP2E-microphone_kicad-eagle-import-sensing_PMU-rescue JP3
U 1 1 5E832128
P 9700 2650
F 0 "JP3" V 9550 2650 59  0000 L BNN
F 1 "HVOUT_VDD" V 9925 2650 59  0000 L BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9700 2650 50  0001 C CNN
F 3 "" H 9700 2650 50  0001 C CNN
	1    9700 2650
	0    -1   -1   0   
$EndComp
$Comp
L DFEH12060D-100M_P3:DFEH12060D-100M=P3 L2
U 1 1 5E8DBFA9
P 7050 2600
F 0 "L2" H 7050 2781 50  0000 C CNN
F 1 "DFEH12060D-100M=P3" H 7050 2690 50  0000 C CNN
F 2 "IND_DFEH12060D-100M=P3" H 7050 2600 50  0001 L BNN
F 3 "N/A" H 7050 2600 50  0001 L BNN
F 4 "6 mm" H 7050 2600 50  0001 L BNN "Field4"
F 5 "Manufacturer Recommendations" H 7050 2600 50  0001 L BNN "Field5"
F 6 "Murata" H 7050 2600 50  0001 L BNN "Field6"
	1    7050 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 2600 6550 2600
Wire Wire Line
	7550 2600 7600 2600
Connection ~ 7600 2600
$Comp
L Device:L L1
U 1 1 5E8F014A
P 6850 3100
F 0 "L1" V 7040 3100 50  0000 C CNN
F 1 "L" V 6949 3100 50  0000 C CNN
F 2 "Inductor_SMD:L_0603_1608Metric" H 6850 3100 50  0001 C CNN
F 3 "~" H 6850 3100 50  0001 C CNN
	1    6850 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6500 3100 6700 3100
Wire Wire Line
	7000 3100 7150 3100
Wire Wire Line
	6500 3300 7150 3300
Connection ~ 7150 3300
$EndSCHEMATC
