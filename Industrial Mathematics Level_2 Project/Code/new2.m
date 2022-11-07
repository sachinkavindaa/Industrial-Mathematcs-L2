
clear all

%input matrices 
n = input('Degree of freedom : ');
mass = zeros(n,n);

%Inputs for spring constants.
Stifness = input('Enter value of the spring constants in N/m \n');
 for i = 2:n+1
    Stifness = [Stifness;input('enter value of the spring constants in N/m \n')];
 end
 
%Inputs for mass of objects.
%  m = input('Enter the mass of objects in Stifnessg \n');
%  for i = 2:n
%     m = [m;input('Enter the mass of objects in Stifnessg \n')];
%  end
 
 for i =1:n
    mass(i,i) = input(['input mass element' num2str(i) ': \n ']); 
 end
 
 %Input for inital displacements.
 C = input('enter the initial displacement with direction of the n blocStifnesss \n');
 for i = 2:n
    C = [C;input('enter the initial displacement with direction of the n blocStifnesss \n')];
 end
 
 %%Calculating natural angualr velocity

[V,D,W] =eig(Stifness,mass);
w = diag(D).^0.5;
Stifness = V.'*Stifness*V;
M = V.'*mass*V;


+ F*sin(2*pi*f*t - Phi)