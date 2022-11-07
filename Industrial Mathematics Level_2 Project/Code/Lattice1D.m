clc;
clear all;
close all;

%%%  User input %%% 


% spring costants kS  
   kS = input('Enter the spring constant: \n');

% mass of atoms or particles m 
   m = input('Enter the mass value: \n');

% The equilibrium separation distance between masses 
   d = input('Enter the separation between two masses: \n');

% Parameters for propagation constant k
   kMin = -3.9999; 
   kMax = 3.9999; 
   kN = 1501;

% Max angular frequency
   omega0 = sqrt(4*kS/m);

% Max GROUP velcoity   
   v0 = d*sqrt(kS/m);

% Propagation constant k [units: pi/d]   
   n = linspace(kMin,kMax,kN);
   k = n.*pi/d;

% Brillouin zone
   n1 = find(n>-1,1); 
   n2 = find(n>1,1);
   
% Wavelength   lambda  
   lambda = 2*pi./k;

% Angular frequency of propagating wave
   omega = omega0 .* abs( sin(n*pi/2) );

% Phase velocity  vP
   vP = abs( (omega)./(k) );

% Group Velocity
   vG = v0 .* abs( cos(n*pi/2) );

%%% MASS DISPLACEMENTS %%%

% Number of mass N
   N = 21;

% X axis
   x = linspace(0,N*d,N);

% Wavelengths
  wL1 = 1.2*N*d;
  wL2 = d/2;

% Mass displacements
   e1 = sin(2*pi*x/wL1);
   e2 = sin(2*pi*x/wL2);  

% Single set of displacements
  Ls = N*d;
  es = sin(2*pi*x/Ls);

  xs = linspace(0,N*d,501);
  Ls1 = N*d;
  es1 = sin(2*pi*xs/Ls1);
  
  Ls2 = d;
  es2 = sin(2*pi*xs/Ls2);

  % GRA{HICS ============================================================ 

   figure(1)
   pos = [0.02 0.2 0.3 0.4];
   set(gcf,'Units','normalized');
   set(gcf,'Position',pos);

   subplot(3,1,1)
   xP = n; yP = omega;
   plot(xP,yP,'b','linewidth',2)
   hold on
   xP = n(n1:n2); yP = omega(n1:n2);
   plot(xP,yP,'r','linewidth',3)
   
   grid on
   set(gca,'fontsize',12)
   xlabel('k   [ \pi  / d ]')
   ylabel('\omega')
   
   subplot(3,1,2)
   xP = n; yP = vP;
   plot(xP,yP,'b','linewidth',2)
   hold on
   xP = n(n1:n2); yP = vP(n1:n2);
   plot(xP,yP,'r','linewidth',3)
   
   grid on
   set(gca,'fontsize',12)
   xlabel('k   [ \pi  / d ]')
   ylabel('v_P')

   subplot(3,1,3)
   xP = n; yP = vG;
   plot(xP,yP,'b','linewidth',2)
   hold on
   xP = n(n1:n2); yP = vG(n1:n2);
   plot(xP,yP,'r','linewidth',3)
   
   grid on
   set(gca,'fontsize',12)
   xlabel('k   [ \pi  / d ]')
   ylabel('v_G')

   figure(2)
   pos = [0.34 0.2 0.3 0.3];
%    set(gcf,'Units','normalized');
%    set(gcf,'Position',pos);
 
   subplot(2,1,1)
   xP = x; yP = e1;
   hPlot = stem(xP,yP,'o');
   set(hPlot,'markersize',8,'markerfacecolor','b')
   grid on
   xlim([-0.1 21.1])
   set(gca,'fontsize',12)
   ylabel('left   right')
   
   subplot(2,1,2)
   xP = x; yP = e2;
   hPlot = stem(xP,yP,'o');
   set(hPlot,'markersize',8,'markerfacecolor','b')
   grid on
   xlim([-0.1 21.1])
   set(gca,'fontsize',12)
   xlabel('x')
   ylabel('left   right')
   
figure(3)
   pos = [0.68 0.2 0.3 0.3];
%    set(gcf,'Units','normalized');
%    set(gcf,'Position',pos);
 
   
   xP = x; yP = es;
   hPlot = plot(xP,yP,'o');
   set(hPlot,'markersize',8,'markerfacecolor','b')
   hold on
   
   xP = xs; yP = es1;
   plot(xP,yP,'b')
   
   yP = es2;
   plot(xP,yP,'r')
      
   grid on
   xlim([-0.1 21.1])
   set(gca,'fontsize',12)
   ylabel('left    e    right')   
   xlabel('x')


 

  

