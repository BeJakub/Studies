clear all;
close all;

N = input('Podaj gorny zakres przedzialu: ');
tic

wynik=1:N;

for i = 2:N
    tab=zeros(1,i);
    for j=2:sqrt(i)
        if tab(j) == 0
            for x=j*j:j:i
                tab(x) = 1;

            end
        end
    end
    wynik(i)=(sum(tab<1)-1);
end

A=sum(tab<1)-1;
fprintf('Ilosc liczb pierwszych w przedziale [1:%d] wynosi: %d\n',N, A);
toc
plot(1:N,wynik);
grid on;
xlabel('Stała N');
ylabel('Liczność zbioru Cn');





% N = input('Podaj gorny zakres przedzialu: ');
% tic
% tab=zeros(1,N);
% 
% for j=2:sqrt(N)
%     if tab(j) == 0
%         for x=j*j:j:N
%             tab(x) = 1;
% 
%         end
%     end
% end
% 
% A=sum(tab<1)-1;
% fprintf('Ilosc liczb pierwszych w przedziale [1:%d] wynosi: %d\n',N, A);
% toc

