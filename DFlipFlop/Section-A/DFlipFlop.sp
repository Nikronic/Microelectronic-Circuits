
*************D FLIP FLOP HSPICE netlist************ 
.include 'C:\synopsys\mosistsmc180.lib'
*netlist---------------------------------------


VDD        vdd       0       1.8

*VCLK      clk      gnd     pulse(0ns  0v  5ns  1v  10ns  0v  15ns  1v)
*vNOTD     NOTD     gnd     pulse(0ns  1v  4ns  0v  14ns  1v)


VCLK      clk       gnd     Pulse(1.8    0 0ps 100ps 100ps 5ns 10ns)
VNCLK     Nclk      gnd     Pulse(0  1.8   0ps 100ps 100ps 5ns 10ns)
vNOTD     NOTD      gnd     Pwl(0ns 1.8 4ns 1.8 4.1ns 0 14ns 0 14.1ns 1.8 )

.option scale=90n
.param N=6
.param P=18
.param SUPPLY=1.8
.GLOBAL vDD GND

.subckt inv a y N=3 P=9

M1 y a gnd gnd NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'
M2 y a vdd vdd PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'

.ends


X1     NOTD   D     inv    N=3   P=9


MP1    1     CLK     D     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN1    1     NCLK    D     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'


 
X2     1      2     inv    N=3   P=9
X3     2      1     inv    N=3   P=9


MP2    3     NCLK    2     VDD     PMOS W='P' L=2 AS='P*5' PS='2*P+10' AD='P*5' PD='2*P+10'
MN2    3     CLK     2     GND     NMOS W='N' L=2 AS='N*5' PS='2*N+10' AD='N*5' PD='2*N+10'




X4     3      Q   inv      N=3   P=9
X5     Q      3   inv      N=3   P=9


.TRAN 10ps 30ns
.options post=2 nomod
.OP

.END


