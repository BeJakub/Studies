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
qg0=[qgN, qgN, qgN*zmiana_qg];
Tzew0=[TzewN, TzewN+zmiana_Tzew, TzewN];
% 
% dTzew = 0;
% dqg = 0.1*qgN;

dTzew = 10;
dqg = 0;
t0 = 1000;
czas_symulacji=5000;

%stan rownowagi
Twew0=(qg0*(a*Kcw+Kcp)+Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);
Tp0=((a*Kcw*Twew0)+Kcp*Tzew0)/(a*Kcw+Kcp);

[t] = sim("lab4_sim");
figure(1);

% Wykres Twew
subplot(211);
hold on;
grid on;
grid on;
xlabel("t [ms]");
ylabel("Twew [℃]");
title("Odpowiedź skokowa Twew(t) w różnych punktach pracy");

% plot(t, Twew(:,1), 'r'); % Pierwszy przebieg Twew
% plot(t, Twew(:,2), 'g'); % Drugi przebieg Twew
% plot(t, Twew(:,3), 'b'); % Trzeci przebieg Twew
plot(t,Twew)

legend('qg0 = qgN; Tzew0 = TzewN','qg0 = qgN; Tzew0 = TzewN+zmiana_Tzew','qg0 = qgN*zmiana_qg; Tzew0 = TzewN');

% Wykres Tp
subplot(212);
hold on;
grid on;
xlabel("t [ms]");
ylabel("Tp [℃]");
title("Odpowiedź skokowa Tp(t) w różnych punktach pracy");
plot(t,Tp)

% plot(t, Tp(:,1), 'r'); % Przebieg Tp
% plot(t, Tp(:,2), 'g'); % Drugi przebieg Tp
% plot(t, Tp(:,3), 'b'); % Trzeci przebieg Tp


