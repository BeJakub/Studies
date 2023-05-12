clear all;
close all;

N=10;
alfa=0.6;
M=5;
dane=zeros(M,N);
x0=rand(M,1);

for i=1:N
    dane(:,i)=x0;
    
    x0=alfa.*x0.*(1-x0);

end
plot(dane')