tic
N=10000;
0;
Pk=4;
n=0;

a = [];
b = [];
err_wykres=1:N;
    x = rand(N,1)*2 - 1;
    y = rand(N,1)*2 - 1;

for i=1:N
    if sqrt(x(i)^2 + y(i)^2) <= 1
        n=n+1;
        a=[a i];
    else
        b=[b i];
    end
    oblicz_pi = (n*4)/i;
    Err = abs(pi - oblicz_pi);
    err_wykres(i) = Err;
end

subplot(2,1,1);
plot (x(a),y(a), 'c.', x(b),y(b),'g.')
title(['\pi = ', num2str(oblicz_pi)])
grid on;
axis equal;
hold on;

subplot(2,1,2);
plot(1:N,err_wykres)
xlabel('Ilość punktów N');
ylabel('Błąd przybliżenia');
hold on;


oblicz_pi = (n*4)/N;
disp("Obliczone pi: ")
disp(oblicz_pi)
Err = abs(pi - oblicz_pi);
disp('Blad przyblizenia: ');
disp(Err);
toc
% plot(x,y,'*g')
% hold on;
% x = [1 -1 -1 1 1];
% y = [1 1 -1 -1 1];
% axis([-1.25 1.25 -1.25 1.25]);
% plot(x,y,'b-','LineWidth',0.5);
% hold on;
% 
% 
% r = 1; a = 0; b = 0;
% t = linspace(0,2*pi,200);
% x = a + r*cos(t); 
% y = b + r*sin(t);
% plot(x,y,'r-','LineWidth',0.5);
% hold on;
% plot([-2.5*r 2.5*r], [0 0],'k:');
% plot([0 0], [-2.5*r 2.5*r],'k:');
% hold on;
% 
% axis equal;
% hold on,



