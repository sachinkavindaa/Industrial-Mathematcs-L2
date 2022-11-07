N = 200;
phi = pi/4;
A = 1;
B = 2;
t0 = -2;
tf = 2;
k = 43
m = 0.81
w = sqrt(2*k/m);
T = 2*pi/w;

t = t0:(tf-t0)/(N-1):T;
x = A*cos(sqrt(2)*w*t);
y = B*cos(w*t-phi);



figure
plot(x,y,'-.b','linewidth',1.5)
grid on;
title('Quasi periodic curve');
xlabel('x(t)');
ylabel('y(t)');
%legend('x(t)', 'y(t)')
