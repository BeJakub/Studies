clear all;
close all;

 % wartosci nominalne
TzewN=-20;
TwewN=20;
TpN=10;
qgN=10000;
a=0.35;
% identyfikacja parametrow statycznych
Kcw=qgN/((TwewN-TzewN)+a*(TwewN-TpN));
Kcp=(a*Kcw*(TwewN-TpN))/(TpN-TzewN);
Kcwp=(Kcp*(TpN-TzewN))/(TwewN-TpN);
%objetosci pomieszczen 
aw=5;
bw=4;
cw=3;
Vw = aw*bw*cw;
Vp =0.5*Vw;
%cieplo wlasciwe i gestosc;
cp = 1000;
ro=1.2;
Cvw = cp*ro*Vw; 
Cvp = cp*ro*Vp;
%warunki poczatkowe
qg0=0;
Tzew0=0;
dTzew = 0;
dqg = 0.1*qgN;

T0p = 1050;
T0w = 1000;
delta_x = 4;
delta_u = 1000;
kw = delta_x/delta_u;
kp = 3/delta_u;

%stan rownowagi
Twew0=(qg0*(a*Kcw+Kcp)+Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);
Tp0=((a*Kcw*Twew0)+Kcp*Tzew0)/(a*Kcw+Kcp);

t0 = 1000;
czas_symulacji=15000;
T_w = 1380-T0w;
T_p = 2030-T0p;
L11 = kw;
M11 = [T_w 1];
L12 = kp;
M12 = [T_p 1];
[t] = sim("lab6_sim");

subplot(2, 1, 1)
plot(t,Twew)
subplot(2,1,2)
plot(t,Tp)
