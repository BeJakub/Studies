
tic
p=1/2;
f = @(v1, v2) (abs(v1.^p) + abs(v2.^p)).^(1/p);
r =1;

N=100000;
a = [];
b = [];

x = 2 *rand(N,1) -1 ;
y = 2 *rand(N,1) -1 ;
for i = 1:N
    if f(x(i),y(i)) <  r
        a = [a i];
    else
        b = [b i];
    end
end

figure();
plot (x(a),y(a), 'r.')
hold on;
plot (x(b),y(b),'b.')
toc

tic 

p=10;
r =1;
N=1000000;

P = 2 *rand(N,2) -1 ;
x = (abs(P(:,1)).^p + abs(P(:,2).^p)).^(1/p);
x = x < r;
in=P(x,:);
out=P(not(x),:);

plot(in(:,1),in(:,2), 'g.')
toc

p=1;
r =1;
N=100000;

P = 2 *rand(N,2) -1 ;
x = (abs(P(:,1)).^p + abs(P(:,2).^p)).^(1/p);
x = x < r;
in=P(x,:);
out=P(not(x),:);
pole_kuli = 4 * sum(x)/N
plot(in(:,1),in(:,2), 'r.',out(:,1),out(:,2), 'b.')
