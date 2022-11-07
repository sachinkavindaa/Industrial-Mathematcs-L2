N = 200;
phi = 3*pi/4;
A = 1;
B = 1;
t0 = -2;
tf = 2;
k = 43
m = 0.81
w = sqrt(2*k/m);
T = 2*pi/w;

t = t0:(tf-t0)/(N-1):T;
x = A*cos(w*t);
y = B*cos(w*t-phi);



figure
plot(x,y,'-.r','linewidth',1.5)
grid on;
title('Harmonic motion of phase \delta = 3\pi/4');
xlabel('x(t)');
ylabel('y(t)');
%legend('x(t)', 'y(t)')
