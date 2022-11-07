clc
clear all;

k1 = 100;
k2 = 200;
k3 = 300;

m1 = 100;
m2 = 100;

M = [m1 0;0 m2];
K = [k1+k2 -k3;-k2 k2+k3];

[modeShape fr]=eig(K,M);
A00 = zeros(2);
A11 = eye(2);
eq = [A00 A11; -inv(M)*K A00];
global eq

max_freq = max(sqrt(diag(fr))/(2*pi));
dt = 1/(max_freq*20);
time = 0:dt:200*dt;
x0 = [0.01 0 0 0];
[tsol,xsol] =ode45('Code1',time,x0);

fig = figure(1)
plot(time,xsol(:,1:2),'linewidth',2)
xlabel('Time')
ylabel('Displacemnt')
legend('x1','x2');
grid on

fig = figure(2)
subplot(2,1,1)
plot(tsol,xsol(:,1),'b'); hold on
plot(tsol,xsol(:,2),'r'); hold off
xlabel('Time [s]');
ylabel('Displacement[m]');
legend('x1','x2');

subplot(2,1,2)
plot(tsol,xsol(:,3),'r'); hold on
plot(tsol,xsol(:,4),'k'); hold off
xlabel('Time [s]');
ylabel('Velocity[m/s]');
legend('xdot1','xdot2');

