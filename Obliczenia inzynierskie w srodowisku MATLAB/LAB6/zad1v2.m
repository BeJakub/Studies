clear all;
close all;

alfa=3.2;
x0=0.12;
xn=linspace(x0,0.8,3);
xn=[0.12 0.25 0.44 0.67 0.83];

N=30;
wynik=zeros(N,5);
for j=1:5
    wynik(1,j)=xn(j);
    for i=1:N
    wynik(i,j)=xn(j);
    xn(j)=alfa*xn(j)*(1-xn(j));
    
    
    end

end

plot(wynik,'.',MarkerSize=8)




