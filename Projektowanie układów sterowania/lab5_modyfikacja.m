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
zmiana_qg = 0.8;
zmiana_Tzew = 10;
qg0=[qgN qgN qgN*zmiana_qg];
Tzew0=[TzewN TzewN+zmiana_Tzew TzewN];
dTzew = 0;
dqg = 0.1*qgN;
M = [Cvw*Cvp (Cvw*(Kcwp+Kcp)+Cvp*(Kcw+Kcwp)) Kcw*Kcwp+Kcw*Kcp+Kcwp*Kcp];
L11 = [Cvp (Kcwp+Kcp)];
L12 = [Cvp*Kcw (Kcw*(Kcwp+Kcp)+Kcwp*Kcp)];
L21 = Kcwp;
L22 = [Kcp*Cvw (Kcw*Kcp + Kcp*Kcwp + Kcwp*Kcw)];
%stan rownowagit0 = 1000;
czas_symulacji=5000;
t0 = 1000;

Twew0=(qg0*(a*Kcw+Kcp)+Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);
Tp0=((a*Kcw*Twew0)+Kcp*Tzew0)/(a*Kcw+Kcp);
[t] = sim("lab5_sim");

subplot(2,1,1)
plot(t,Twew)
xlabel("t [ms]");
ylabel("Twew [℃]");
grid on;
title("Odpowiedź skokowa Twew(t) z wykorzystaniem transmitancji");

subplot(2,1,2)
plot(t,Tp)
grid on;
xlabel("t [ms]");
ylabel("Tp [℃]");
title("Odpowiedź skokowa Tp(t) z wykorzystaniem transmitancji");
