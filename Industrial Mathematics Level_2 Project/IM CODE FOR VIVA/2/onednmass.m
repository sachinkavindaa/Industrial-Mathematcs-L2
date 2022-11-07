clear all; 
close all;
clc;

% Assume spring constants are equivalent and masses are equivelent.

%input Mass Value
m = input('Enter value of Mass Weight (kg):   \n');
%Input for spring constants.
k = input('Enter value of the spring constants (N/m): \n');
%Input for spring constants.
n = input('Number of Masses: \n');
% simulation time
t = input('Simulation time period: \n');

tStep=0.001;
mode=2; % must be <= n

% Create mass and stiffness matrices based on generalized FBD's

% mass matrix is an identity matrix
M=m.*eye(n); 
e=ones(n,1);

% stiffness matrix
K=spdiags([-k.*e 2*k.*e -k.*e],-1:1,n,n);

% make the K matrix into a full matrix
K=full(K); 

% Returns phi (eigenvectors) and lambda (eigenvalues) - M*phi*lambda=K*phi
[phi,lambda]=eig(K,M);
% Get natural frequencies from eigenvalues
Wn=sqrt(diag(lambda)); 

% Time step setup
% total number of iterations
iterations=t/tStep;

% time vector (for plotting purposes)
tVector=tStep.*(1:iterations); 

% Pre-allocate arrays for speed
x=zeros(iterations,n);
v=zeros(iterations,n);
a=zeros(iterations,n);

% initial displacements governed by desired mode
x(1,:)=phi(:,mode); 

% Iteratively solve equations of motion using Semi-implicit Euler
for i=2:iterations
    for j=1:n
        a(i,j)=(-K(j,:)./M(j,j))*(x(i-1,:)');
        v(i,j)=v(i-1,j)+a(i,j)*tStep;
        x(i,j)=x(i-1,j)+v(i,j)*tStep;
    end
end

% Plot the results
for k=1:n
    subplot(3,1,1); hold on; grid on;
    plot(tVector,x(:,k))
    subplot(3,1,2); hold on; grid on;
    plot(tVector,v(:,k))
    subplot(3,1,3); hold on; grid on;
    plot(tVector,a(:,k))
end

subplot(3,1,1);
title('Position, Velocity, and Acceleration as a Function of Time');
ylabel('Position (m)');
grid on;

subplot(3,1,2);
ylabel('Velocity (m/s)');
subplot(3,1,3);
ylabel('Acceleration (m/s^2)');
xlabel('Time (s)');
grid on;

