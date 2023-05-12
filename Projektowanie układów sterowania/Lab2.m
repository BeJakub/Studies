%GENEROWANIE RODZINY CHARAKTERYSTYK STATYCZNYCH
clear all;
close all;
 % wartosci nominalne
TzewN=-20;
TwewN=20;
TpN=10;
qgN=10*1e3;
a=0.35;
% identyfikacja parametrow statycznych
Kcw=qgN/((TwewN-TzewN)+a*(TwewN-TpN));
Kcp=(a*Kcw*(TwewN-TpN))/(TpN-TzewN);
Kcwp=(Kcp*(TpN-TzewN))/(TwewN-TpN);

% charaketrystyka statyczna I i II - Twew (qg), Tp(qg)
qg0=0:0.1*qgN:qgN;
% Tzew=TzewN;
Tzew=[-20;-5;5;20];


figure();

for i=1:length(Tzew)
Twew0=(qg0*(a*Kcw+Kcp)+Tzew(i)*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);
Tp0=((a*Kcw*Twew0)+Kcp*Tzew(i))/(a*Kcw+Kcp);

subplot(2,2,1);
hold on;
grid on;
if i == 1
  plot (qg0,Twew0);
else
  plot (qg0,Twew0,'--');
end



subplot(2,2,2);
hold on ;
grid on ;
if i == 1
    plot (qg0,Tp0);
else
    plot (qg0,Tp0,'--');
end
end
subplot(2,2,1);
title("Charakterystyka statyczna Twew(qg)");
xlabel("qg [W]");
ylabel("Twew [℃]");
plot(qgN,TwewN,'ro');
legend('TzewN=-20','Tzew = -5','Tzew = 5','Tzew = 20','Punkt nominalny');



subplot(2,2,2);
title("Charakterystyka statyczna Tp(qg)");
xlabel("qg [W]");
ylabel("Tp [℃]");
plot(qgN,TpN,'ro');


% charaketrystyka statyczna III i IV -Twew(Tzew) Tp ( Tzew ), gdzie qg jest parametrem
Tzew0 = -20:20; % wektor wartosci wejsciowych
qg = [qgN,0.5*qgN,0.1*qgN,0] ; % qg - tutaj parametr wykresu
for i=1:length(qg)
Twew0 = (qg(i)*(a*Kcw+Kcp)+Tzew0*(Kcw*(a*Kcw+Kcp)+(a*Kcw*Kcp)))/(Kcw*(a*Kcw+Kcp)+a*Kcw*Kcp);;
Tp0 = ((a*Kcw*Twew0)+Kcp*Tzew0)/(a*Kcw+Kcp);

subplot(2,2,3);
hold on ;
grid on ;
if i == 1
plot (Tzew0,Twew0);
else
plot (Tzew0,Twew0,'--');
end

subplot(2,2,4);
hold on ;
grid on ;
if i == 1
plot (Tzew0,Tp0);
else
    plot (Tzew0,Tp0,'--');
end

end


subplot(2,2,3);
title("Charakterystyka statyczna Twew(Tzew)");
xlabel("Tzew [℃]");
ylabel("Twew [℃]");
plot(TzewN,TwewN,'ro');
legend('qgN=10000','qg = 5000','qg = 1000','qg = 0','Punkt nominalny');

subplot(2,2,4);
title("Charakterystyka statyczna Tp(Tzew)");
xlabel("Tzew [℃]");
ylabel("Tp [℃]");
plot(TzewN,TpN,'ro');

