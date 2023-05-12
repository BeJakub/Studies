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

dTzew = 0;
dqg = 0.1*qgN;
dTz=2;

T0p = 1060;
T0w = 1000;
delta_x = 4;
delta_u = 1000;
kw = delta_x/delta_u;
k = 3/delta_u;
%lab7 zmienne
%setpoint
Tz0=TpN;
Tzew0=TzewN;



%stan rownowagi
% Twew0=(qg0*(a*Kcw+Kcp)+Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);
% Tp0=((a*Kcw*Twew0)+Kcp*Tzew0)/(a*Kcw+Kcp);
Tp0=Tz0;

Twew0=(Tp0*(a*Kcw+Kcp)-Kcp*Tzew0)/(a*Kcw);
qg0=((Twew0*(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp))-Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(a*Kcw+Kcp);


t0 = 1000;
czas_symulacji=50000;
T_w = 1380-T0w;
T_p = 2040-T0p;
L11 = kw;
M11 = [T_w 1];
L12 = k;
M12 = [T_p 1];
%DLa Tp
kpisa=(0.9*2030)/(k*T0p);
Tiisa=3.33*T0p;
kpind=kpisa;
kiind=kpisa/Tiisa;
kd=0;
%Dla Twew
kpisaw=(0.9*1380)/(k*T0w);
Tiisaw=3.33*T0w;
kpindw=kpisaw;
kiindw=kpisaw/Tiisaw;

[t] = sim("lab7_sim");

subplot(2, 1, 1)
plot(t,Twew)
subplot(2,1,2)
plot(t,Tp)
