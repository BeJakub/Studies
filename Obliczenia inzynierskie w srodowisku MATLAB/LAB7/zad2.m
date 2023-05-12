clear all;
c1=0;
c2=1;
h=0.1;
% t=0:h:100;

alfa=1;

x0=[c1];
pochodna_x0=[c2];
%metoda numeryczna
for i=2:1:100
x0(i)=x0(i-1)+h*pochodna_x0(i-1);
pochodna_x0(i)=pochodna_x0(i-1)-h*alfa*x0(i);
end
%metoda analityczna 
t = 1:0.1:100;
for i = 1:1:length(t)
    x0_analityczna(i) = sin(1/10*t(i));
    pochodna_x0_analityczna(i) = cos(t(i));
end
figure(1)
hold on;
plot(x0,'r')
plot(pochodna_x0,'b')
xlabel('t');
ylabel('x(t)');
title('Metoda numeryczna');
legend('v_1(t) - funkcja','v_2(t) - pochodna funkcji');
grid on


figure(2)
hold on;
plot(x0);
plot(linspace(1,100,length(t)),x0_analityczna,'g')
title('Sinus');
xlabel('t');
ylabel('v_1(t)');
legend('Rozwiązanie analityczne','Rozwiązanie numeryczne')
grid on



