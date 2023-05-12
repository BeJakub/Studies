clear;
close all
h = 0.1;
t = 0:h:100;
teta = pi/30;
g = 9.81;
l = 10;

analityczna = [];

for i = 1:1:length(t)
analityczna(i) = teta*cos(t(i)*(sqrt(g/l)));
end

num = [0];

num2 = [teta];



for i = 2:1:length(t)
%num(i) = num(i-1) - h * (g/l) * sin(num2(i-1));\
num(i) = num(i-1) - h * (g/l) * num2(i-1);
num2(i) = num2(i-1) + num(i) * h;
end

hold on;
plot(t, analityczna, 'r');
plot(t, num2, 'b');
xlabel('Czas');
ylabel('Położenie');
legend('Metoda analityczna', 'Metoda numeryczna');