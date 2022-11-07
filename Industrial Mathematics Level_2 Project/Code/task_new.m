clear all
close all
clc

% Initialise variables
%input Mass Value
m = input('Enter value of Mass Weight (kg):   \n');
%Input for spring constants.
k = input('Enter value of the spring constants (N/m): \n');
%Input length of spring.
l = input('Enter value of length of spring (m): \n');

h = 0.01;
t = 0:h:100;
N = length(t);

% Initialise vectors
z1    = zeros(N,1);
z2    = zeros(N,1);
z3    = zeros(N,1);
z4    = zeros(N,1);

w = (-k)/m;

% Initialise derivative functions

dz1 = @(t, z1, z2, z3, z4) z3;               % dx/dt = z1 
dz2 = @(t, z1, z2, z3, z4) z4;               % dy/dt = z2 
dz3 = @(t, z1, z2, z3, z4) w*( (((z1+l)*(sqrt((z1+l).^2 + z2.^2)-l))./(sqrt( (z1+l).^2 + z2.^2 )))+...
                               (( z1*(sqrt( (z2+l).^2 + z1.^2)-l))./(sqrt( (z2+l).^2 + z1.^2)))-...
                               (( (l-z1)*(sqrt( (l-z1).^2 + z2.^2)-l))./(sqrt( (l-z1).^2 + z2.^2)))+...
                               ((z1*(sqrt((l-z2).^2 + z1.^2)-l))./(sqrt((l-z2).^2 + z1.^2 )))); % dz1/dt = z3
dz4 = @(t, z1, z2, z3, z4) w*( ((z2*(sqrt((z1+l).^2 + z2.^2)-l))./(sqrt((z1+l).^2 + z2.^2)))+...
                               ((z2*(sqrt((l-z1).^2 + z2.^2)-l))./(sqrt( (l-z1).^2 + z2.^2)))+...
                               (((z2+l)*(sqrt(z1.^2 + (z2+l).^2)-l))./(sqrt(z1.^2 + (z2+l).^2)))+...
                               (((z2-l)*(sqrt(z1.^2 + (l-z2).^2)-l))./(sqrt(z1.^2 + (l-z2).^2))));  % dz2/dt = z4 

%Starting conditions

z1(1) = 0; 
z2(1) = 2;
z3(1) = 0;
z4(1) = 1;

% Initialise K vectors

kz1 = zeros(1,4); % to store K values for z1
kz2 = zeros(1,4); % to store K values for z2
kz3 = zeros(1,4); % to store K values for z3
kz4 = zeros(1,4); % to store K values for z4

b = [1 2 2 1];   % RK4 coefficients


% Iterate, computing each K value in turn, then the i+1 step values by Runge kutta method

for i = 1:(N-1)
    kz1(1) = dz1(t(i), z1(i), z2(i), z3(i) , z4(i));
    kz2(1) = dz2(t(i), z1(i), z2(i), z3(i) , z4(i));
    kz3(1) = dz3(t(i), z1(i), z2(i), z3(i) , z4(i));
    kz4(1) = dz4(t(i), z1(i), z2(i), z3(i) , z4(i));

    kz1(2) = dz1(t(i) + (h/2), z1(i) + (h/2)*kz1(1), z2(i) + (h/2)*kz2(1), z3(i) + (h/2)*kz3(1) , z4(i) + (h/2)*kz4(1));
    kz2(2) = dz2(t(i) + (h/2), z1(i) + (h/2)*kz1(1), z2(i) + (h/2)*kz2(1), z3(i) + (h/2)*kz3(1) , z4(i) + (h/2)*kz4(1));
    kz3(2) = dz3(t(i) + (h/2), z1(i) + (h/2)*kz1(1), z2(i) + (h/2)*kz2(1), z3(i) + (h/2)*kz3(1) , z4(i) + (h/2)*kz4(1));
    kz4(2) = dz4(t(i) + (h/2), z1(i) + (h/2)*kz1(1), z2(i) + (h/2)*kz2(1), z3(i) + (h/2)*kz3(1) , z4(i) + (h/2)*kz4(1));
    
    kz1(3) = dz1(t(i) + (h/2), z1(i) + (h/2)*kz1(2), z2(i) + (h/2)*kz2(2), z3(i) + (h/2)*kz3(2) , z4(i) + (h/2)*kz4(2));
    kz2(3) = dz2(t(i) + (h/2), z1(i) + (h/2)*kz1(2), z2(i) + (h/2)*kz2(2), z3(i) + (h/2)*kz3(2) , z4(i) + (h/2)*kz4(2));
    kz3(3) = dz3(t(i) + (h/2), z1(i) + (h/2)*kz1(2), z2(i) + (h/2)*kz2(2), z3(i) + (h/2)*kz3(2) , z4(i) + (h/2)*kz4(2));
    kz4(3) = dz4(t(i) + (h/2), z1(i) + (h/2)*kz1(2), z2(i) + (h/2)*kz2(2), z3(i) + (h/2)*kz3(2) , z4(i) + (h/2)*kz4(2));

    kz1(4) = dz1(t(i) + h, z1(i) + h*kz1(3), z2(i) + h*kz2(3), z3(i) + h*kz3(3) , z4(i)+ h*kz4(3));
    kz2(4) = dz2(t(i) + h, z1(i) + h*kz1(3), z2(i) + h*kz2(3), z3(i) + h*kz3(3) , z4(i)+ h*kz4(3));
    kz3(4) = dz3(t(i) + h, z1(i) + h*kz1(3), z2(i) + h*kz2(3), z3(i) + h*kz3(3) , z4(i)+ h*kz4(3));
    kz4(4) = dz4(t(i) + h, z1(i) + h*kz1(3), z2(i) + h*kz2(3), z3(i) + h*kz3(3) , z4(i)+ h*kz4(3));
    
    z1(i+1) = z1(i) + (h/6)*sum(b.*kz1);      
    z2(i+1) = z2(i) + (h/6)*sum(b.*kz2);      
    z3(i+1) = z3(i) + (h/6)*sum(b.*kz3);
    z4(i+1) = z4(i) + (h/6)*sum(b.*kz4);
     
    
end   

%displacments of springs

spring_1 = sqrt((z1+l).^2+ z2.^2)-l ;
spring_2 = sqrt((z2+l).^2+ z1.^2)-l ;
spring_3 = l- sqrt((l-z2).^2+ z1.^2);
spring_4 = l- sqrt((l-z1).^2+ z2.^2); 

% Group together in one solution matrix

disp('Values of t z1 z2 z3 z4 spring_1 spring_2 spring_3 spring_4 ');
Answer_Matrix = [t' z1 z2 z3 z4 spring_1 spring_2 spring_3 spring_4 ];


%plot results

figure(1);
hold on;

subplot(3,2,1); plot(t,z3,'r','linewidth',1)
ylabel('Accerlaration ')
xlabel('Time')
title('Accerlaration of mass horizontal Vs Time')
grid on;

subplot(3,2,2); plot(t,z4,'r','linewidth',1)
ylabel('Accerlaration of mass vertical')
xlabel('Time')
title(' Accerlaration of mass vertical Vs Time')
grid on;

subplot(3,2,3); plot(t,spring_1,'k','linewidth',1)
ylabel('spring 1')
xlabel('Time')
title('spring 1 Vs Time')
grid on;

subplot(3,2,4); plot(t,spring_2,'k','linewidth',1)
ylabel('spring 2')
xlabel('Time')
title('spring 2 Vs Time')
grid on;

subplot(3,2,5); plot(t,spring_3,'k','linewidth',1)
ylabel('spring 3')
xlabel('Time')
title('spring 3 Vs Time')
grid on;

subplot(3,2,6); plot(t,spring_4,'k','linewidth',1)
ylabel('spring 4')
xlabel('Time')
title('spring 4 Vs Time')
grid on;

figure(2);
plot(z1(1:end),z2(1:end),'r','linewidth',1)
ylabel('y-axis,horizontal position')
xlabel('x-axis,vertical position')
title('Vertical position and horizontl position')
grid on;


D=[z1 z2];
save path.mat D;