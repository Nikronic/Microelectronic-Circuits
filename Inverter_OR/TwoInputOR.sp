
*************CMOS Inverter HSPICE netlist************ 
************* note: all instruction comments use myriad amount of '*' at the end like this one.************** 
.include 'C:\synopsys\mosistsmc180.lib'
*netlist--------------------------------------- 
.param SUPPLY=1.8
*we define these parameters as a baseline for W and L in all transistors. ******************************
.param Wbase=.18u
.param Lbase=.18u

*VDD Vdd 0 1.8 
VDD Vdd 0 'SUPPLY'
VA a 0 PULSE ('SUPPLY' 0 0ps 100ps 100ps 8ns 16ns)
VB b 0 PWL (0 0 20ns 0 20.1n 'SUPPLY' 36n 'SUPPLY' 36.1n 0 40n 0 40.1n 'SUPPLY' 60n 'SUPPLY')

*NOR gate
*note: 5*Wbase = 0.9u **************************************
MPA ab a VDD VDD PMOS L='Lbase' W='5*Wbase' 		*Darin Gate Source Bulk Model_Name L=length W=width
MPB nor b ab VDD PMOS L='Lbase' W='5*Wbase' 		*Darin Gate Source Bulk Model_Name L=length W=width
MNA nor a 0 0 NMOS L='Lbase' W='Wbase' 		        *Darin Gate Source Bulk Model_Name L=length W=width
MNB nor b 0 0 NMOS L='Lbase' W='Wbase' 	        	*Darin Gate Source Bulk Model_Name L=length W=width

*final INVERTER gate
*note: 2*Wbase = 0.36u **************************************
MPO or nor VDD VDD PMOS L='Lbase' W='Wbase' 		*Darin Gate Source Bulk Model_Name L=length W=width
MNO or nor 0 0 NMOS L='2*Lbase' W='Wbase'		    *Darin Gate Source Bulk Model_Name L=length W=width


Cor or gnd 10fF
* Note: I did not included any Capacitor at the end of NOR gate

*extra control information--------------------- 
.options post=2 nomod 
.op 
*analysis-------------------------------------- 
.TRAN 10ps 60ns * transient analysis: Step end_time 

.measure tp1				
+     TRIG v(nor)		VAL='SUPPLY/2' FALL=1
+     TARG v(or)	  	VAL='SUPPLY/2' RISE=1

.measure tp2				
+     TRIG v(nor)		VAL='SUPPLY/2' RISE=1
+     TARG v(or)	  	VAL='SUPPLY/2' FALL=1

.measure tp3				
+     TRIG v(nor)		VAL='SUPPLY/2' FALL=2
+     TARG v(or)	  	VAL='SUPPLY/2' RISE=2

.measure tp4				
+     TRIG v(nor)		VAL='SUPPLY/2' RISE=2
+     TARG v(or)	  	VAL='SUPPLY/2' FALL=2

.measure tp5				
+     TRIG v(nor)		VAL='SUPPLY/2' FALL=3
+     TARG v(or)	  	VAL='SUPPLY/2' RISE=3


.END 