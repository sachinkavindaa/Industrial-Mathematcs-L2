clear all; 
close all;
clc;
tic

%input mass_1
m1 = input('Enter value of mass_1 (kg):   \n');
%input mass_2
m2 = input('Enter value of mass_2 (kg):   \n');

%Inputs for spring constants.
k1 = input('Enter value of the spring constants (N/m): \n');
%Inputs for spring constants.
k2 = input('Enter value of the spring constants (N/m): \n');
%Inputs for spring constants.
k3 = input('Enter value of the spring constants (N/m): \n');

x10=1; % mass 1 initial position 
x20=1; % mass 2 initial position 

v10=0; % mass 1 initial velocity 
v20=0; % mass 2 initial velocity 

% Set time step 
simTime=1; % simulation time 
tStep=0.01; % simulation time step

iterations=simTime/tStep;
t=0:iterations;

% variables for speed
x1=zeros(iterations,1);
x1(1,:)=x10;
x2=zeros(iterations,1);
x2(1,:)=x20;

v1=zeros(iterations,1);
v1(1,:)=v10;
v2=zeros(iterations,1);
v2(1,:)=v20;

a1=zeros(iterations,1);
a1(1,:)=( k3*(x20-x10) + -k1*x10)/m1;
a2=zeros(iterations,1);
a2(1,:)= (-(k2+k3)*x20 + k3*x10)/m2;

% Set up video
v=VideoWriter('twomass.avi');
v.FrameRate=100;
open(v);

set(gcf, 'Position',  [50, 50, 700, 600])%positions of plot

for n=2:(iterations+1)
    
  %euler method
    
  x1(n,:)=x1(n-1,:)+v1(n-1,:)*tStep;
  x2(n,:)=x2(n-1,:)+v2(n-1,:)*tStep;
  
  v1(n,:)=v1(n-1,:)+a1(n-1,:)*tStep;
  v2(n,:)=v2(n-1,:)+a2(n-1,:)*tStep;
  
  a1(n,:)=(k3*((x2(n,:))-(x1(n,:)))+-k1*(x1(n,:)))/m1;
  a2(n,:)=(-(k2+k3)*(x2(n,:))+k3*(x1(n,:)))/m2;

  % Plot for the video
  subplot(4,1,1)
  
  hold on;
  plot(t(:,1:n),x1(1:n,:),'r')
  plot(t(:,1:n),x2(1:n,:),'m')
  
  xlim([0 iterations])
  ylabel('Position(m)')
  legend('mass 1','mass 2')
  
  subplot(4,1,2)
  
  hold on;
  plot(t(:,1:n),v1(1:n,:),'b')
  plot(t(:,1:n),v2(1:n,:),'c')
 
  xlim([0 iterations])
  ylabel('Velocity(m/s)')
  legend('mass 1','mass 2')
  
  subplot(4,1,3)
  
  hold on;
  plot(t(:,1:n),a1(1:n,:),'g')
  plot(t(:,1:n),a2(1:n,:),'y')
 
  xlim([0 iterations])
  ylabel('Acceleration(m/s^2)')
  legend('mass 1','mass 2')
  
  subplot(4,1,4)
  
  hold on;
  fill([0 9 9 0],[0 0 1.5 1.5],'w'); % clears background
  
  plot([x1(n,:)+3 0],[0.25 0.25],'k'); % springs
  plot([x1(n,:)+3 x2(n,:)+6],[0.25 0.25],'k');
  plot([x2(n,:)+6 9],[0.25 0.25],'k');
  
  fill([x1(n,:)+2.75 x1(n,:)+3.25 x1(n,:)+3.25 x1(n,:)+2.75],[0 0 0.5 0.5],'g'); % mass 1
  fill([x2(n,:)+5.75 x2(n,:)+6.25 x2(n,:)+6.25 x2(n,:)+5.75],[0 0 0.5 0.5],'g'); % mass 2
  
  fill([0 0.1 0.1 0],[0 0 1 1],[0.5 0.5 0.5]);
  fill([8.9 9 9 8.9],[0 0 1 1],[0.5 0.5 0.5]);

  xlim([0 9]);
  ylim([0 1.5]);
  frame=getframe(gcf);
  writeVideo(v,frame)
  
end
close(v);

figure,

subplot(3,1,1)
hold on;
plot(t',x1,'r')
plot(t',x2,'m')
ylabel('Position (m)')
title('Position, Velocity, & Acceleration as a Function of Time')
legend('mass1','mass2')
grid on

subplot(3,1,2)
hold on;
plot(t',v1,'b')
plot(t',v2,'c')
ylabel('Velocity (m/s)')
legend('mass1','mass2')
grid on

subplot(3,1,3)
hold on;
plot(t',a1,'g')
plot(t',a2,'y')
ylabel('Acceleration (m/s^2)')
xlabel('time (iterations)')
legend('mass1','mass2')
grid on

toc
