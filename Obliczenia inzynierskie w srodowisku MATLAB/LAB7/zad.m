clear all;
close all
a = 2;
h = 0.1;
t = 0:h:3;
analityczna = [];
t_h = 0:h:3;
numeryczna = [1];
hold on;
for i = 1:1:length(t)
analityczna(i) = exp(a * t(i));
end
plot(linspace(0,3,length(t)), analityczna, 'b');
hold on;
for j = 2:1:length(t_h)
numeryczna(j) = numeryczna(j-1) + h * a * numeryczna(j-1);
end
stairs(t_h, numeryczna,'r');
xlabel('t');
ylabel('x(t)');
legend('Metoda analityczna', 'Metoda numeryczna');
for i = 1:1:length(t)
przebieg_bledu(i) = numeryczna(i) - analityczna(i);
end
figure(2)
plot(linspace(0,3.,length(t)), przebieg_bledu, 'b');
xlabel('t');
ylabel('x_n_u_m(t) - x_a_n(t)');