
*************D FLIP FLOP HSPICE netlist************ 
.include 'C:\synopsys\mosistsmc180.lib'
*netlist---------------------------------------


VDD        vdd       0       1.8

*VCLK      clk      gnd     pulse(0ns  0v  5ns  1v  10ns  0v  15ns  1v)
*vNOTD     NOTD     gnd     pulse(0ns  1v  4ns  0v  14ns  1v)


VCLK      clk       gnd     Pulse(1.8    0 10ps 100ps 100ps 5ns 10ns)
VNCLK     Nclk      gnd     Pulse(0  1.8   10ps 100ps 100ps 5ns 10ns)
VNOTD     NOTD      gnd     Pwl(0ns 1.8 4ns 1.8 4.1ns 0 14ns 0 14.1ns 1.8 )


.option scale=90n
.param N=6
.param P=18
.param SUPPLY=1.8
.GLOBAL vDD GND

.subckt inv a y N=3 P=9

M1 y a gnd gnd NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'
M2 y a vdd vdd PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'

.ends

X0     NOTD   D     inv    N=3   P=9

MP1    a     CLK     D     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN1    a     NCLK    D     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'
 
X1     a      c     inv    N=3   P=9
X4     c      b     inv    N=3   P=9

MP2    a     NCLK    b     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN2    a     CLK     b     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'

MP3    NOTQ     NCLK    c     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN3    NOTQ     CLK     c     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'

X2     NOTQ      Q   inv      N=3   P=9
X3     Q         e   inv      N=3   P=9

MP4    NOTQ     CLK      e     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN4    NOTQ     NCLK     e     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'


.TRAN 10ps 30ns
.options post=2 nomod
.OP


.measure tpdr				* rising propagation delay
+     TRIG v(CLK)		VAL='SUPPLY/2' RISE=2
+     TARG v(Q)	  	VAL='SUPPLY/2' FALL=1
.measure tpdf				* falling propagation delay
+     TRIG v(CLK)  	VAL='SUPPLY/2' RISE=0
+     TARG v(Q)  	VAL='SUPPLY/2' RISE=1 


.END


