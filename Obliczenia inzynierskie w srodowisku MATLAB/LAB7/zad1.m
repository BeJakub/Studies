clear all;

x0=[1];
h=0.01;
t=0:h:3;

alfa=1;

for i=2:1:length(t)
x0(i)=h*alfa*x0(i-1)+x0(i-1);
   
end
for j=1:1:length(t)
    x_an(j)=exp(alfa*t(j));
end
err=x0-x_an;

figure(1);
plot(t,x_an)
hold on;
stairs(t,x0,'r')
xlabel('t');
ylabel('x(t)');
figure(2);
plot(t,err)
xlabel('t');
ylabel("x.num-x.an");

