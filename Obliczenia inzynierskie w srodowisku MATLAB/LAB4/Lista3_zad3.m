
% d = 3;
% % V badanego obszaru
% V_bo = 2^d;
% p=2;
% 
% N = 1000000;
% 
% X = 2*rand(N,d) - 1;
% 
% r = (sum(X.^p,2)).^(1/p);
% c = r <= 1;
% 
% V = sum(c)/N*V_bo
% 

% V badanego obszaru
p=10;
N = 1000000;

for d = 1:20
V_bo = 2^d;
X = 2*rand(N,d) - 1;

r = (sum(X.^p,2)).^(1/p);
c = r <= 1;

V(d) = sum(c)/N*V_bo;
end

plot(1:20, V,'-g.' )
grid on;
