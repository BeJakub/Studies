clear all;
close all;

N=1000;
alfa=linspace(2,4,N);

M=100;


x0=rand(M,1);

for j=1:N
    
   x0=alfa.*x0.*(1-x0);

end
plot(alfa,x0,'.','MarkerSize',1)
xlabel('Alpha')
ylabel('Xn')