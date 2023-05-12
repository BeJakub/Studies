clear all;
close all;

N = input("Podaj rozmiar macierzy: ");
R = 5;


if mod(N,2) == 0
   N = N+1;
end


A = zeros(N, N);
srodek = [ceil(N/2) ceil(N/2)];    

for i=1:N 
    for j=1:N
        odc = sqrt((i - srodek(1))^2 + (j - srodek(2))^2);
        if odc < R
            A(i,j) = 1;
        end
    end
end
disp(A)


