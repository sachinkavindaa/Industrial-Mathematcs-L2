clc;
clear all;

%Degree of freedom
%N = input('DOF:   \n');

%input mass_1
M1 = input('Enter value of mass_1 (kg):   \n');
%input mass_2
M2 = input('Enter value of mass_2 (kg):   \n');

%Inputs for spring constants.
K1 = input('Enter value of the spring constants (N/m): \n');

%Inputs for spring constants.
K2 = input('Enter value of the spring constants (N/m): \n');

%Inputs for spring constants.
K3 = input('Enter value of the spring constants (N/m): \n');

%Mass matrix
M = [M1 0; 0 M2];

%Stiffness matrix
K = [K1+K2 -K2 ; -K2 K2+K3];

%Estimation natural frequncies and mode shapes

[modeShape fr] = eig(K,M);

%Coffecient matrix

A00 = zeros(2);
A11 = eye(2);
CC = [A00 A11; -inv(M)*K A00];
global CC

%%Time step and time vector

max_freq = max(sqrt(diag(fr))/(2*pi)); %maximum frequency in Hz
dt = 1/(max_freq*20);
Nstep = 100;
time = 0:dt:Nstep*dt;

y0 = [0.5 0.5 0 0]; %[disp1 disp2 vol1 vol2] inatial condition
[tsol,ysol] = ode45('testcode',time,y0);

y1 = ysol(:,1);
y2 = ysol(:,2);
v1 = ysol(:,3);
v2 = ysol(:,4);

idxmin = find(y1 == max(y1))
idxmax = find(y1 == min(y1))



figure()
plot(time,y1,'--r','linewidth',1);
hold on
plot(time,y2,'-.b','linewidth',1);
hold off
% plot(y1(idxmin),y1(idxmax),'*','MarkerFaceColor','red',...
%     'MarkerSize',10)
% % hold on
% % plot(y2(idxmax),y1(idxmax),'-p','MarkerFaceColor','black',...
% %     'MarkerSize',10)
% hold off
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Displacement VS Time')
legend('Mass 1','Mass 2');
grid on

figure()
plot(time,v1,'--r','linewidth',1);
hold on
plot(time,v2,'-.b','linewidth',1);
hold on
xlabel('Time(s)');
ylabel('Velocity (m/s)');
title('Velocity VS Time')
legend('Mass 1','Mass 2');
grid on











