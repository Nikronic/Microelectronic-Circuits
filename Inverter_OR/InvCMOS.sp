
*************CMOS Inverter HSPICE netlist************ 
.include 'C:\synopsys\mosistsmc180.lib'
*netlist--------------------------------------- 
.param SUPPLY=1.8
.param Wn=.36u
.param Ln=.18u
.param Wp=1.08u
.param Lp=.18u

*VDD Vdd 0 1.8 
VDD Vdd 0 'SUPPLY'
VIN A0 0 PULSE 0 'SUPPLY' 0NS 100PS 100PS 15NS 30NS 	*input line: square wave, amp. rise t, fall t, on t, period 

MP1 vdd A0 Vout vdd PMOS L=Lp W=Wp 		*Darin Gate Source Bulk Model_Name L=length W=width
MN1 Vout A0 0 0 NMOS L=Ln W=Wn 		*Darin Gate Source Bulk Model_Name L=length W=width

C Vout gnd 100fF

*extra control information--------------------- 
.options post=2 nomod 
.op 
*analysis-------------------------------------- 
.TRAN 10ps 60ns * transient analysis: Step end_time 
.measure charge INTEGRAL I(Vdd) FROM=0ns TO=30ns
.measure power param='-charge * SUPPLY'

.measure tpdr				* rising propagation delay
+     TRIG v(A0)		VAL='SUPPLY/2' FALL=1 
+     TARG v(Vout)	  	VAL='SUPPLY/2' RISE=1
.measure tpdf				* falling propagation delay
+     TRIG v(A0)  	VAL='SUPPLY/2' RISE=2
+     TARG v(Vout)  	VAL='SUPPLY/2' FALL=2 
.measure tpd param='(tpdr+tpdf)/2'	* average propagation delay

.measure trise					* rise time
+	TRIG v(Vout)	VAL='0.1 * SUPPLY' RISE=1
+	TARG v(Vout)	VAL='0.9 * SUPPLY' RISE=1
.measure tfall					* fall time
+	TRIG v(Vout)	VAL='0.9 * SUPPLY' FALL=2
+	TARG v(Vout)	VAL='0.1 * SUPPLY' FALL=2


.END 