clear 
close all
clc


k1=100; % Mass 1 spring constant (i/m)
k2=200; % Mass 2 spring constant (i/m)
k3=300; % Mass 2 spring constant (i/m)
m1=100; % Mass 1 mass (kg)
m2=100; % Mass 2 mass (kg)

% >>>>>  Number of grid points 
  N = 201;
  
% >>>>>  t variable
  tMin = 0;
  tMax = 1;
  
% >>>>>  initial value for x and y variable
  x = zeros(1,N); y = zeros(1,N); 
  x(1) = 1;
  y(1) = -1;
  

% SETUP  ==============================================================  
% t interval and step size
  t = linspace(tMin,tMax,N);
  h = t(2) - t(1);
% xDot & yDot variables as a function of t
%      at x(nX) & y(nY) (calls function XDOT & YDOT)   
%  nX = 1; nY = 1;
%  xDot = XDOT(t,x(nX), y(nY));
%  yDot = YDOT(t,x(nX),y(nY));
  
% FUNCTION  ===========================================================



    XDOT = @(x,y,k1,k2,m1) (-(k1*x-k2*(y-x))/m1);

    YDOT = @(x,y,k3,k2,m2) (-(k2*(y-x)+k3*y)/m2);

  
% Compute y and yDdot values as a function of time =====================
for n = 1 : N-1
   kx1 = h*XDOT( x(n), y(n));
   ky1 = h*YDOT( x(n), y(n));
   
   kx2 = h*XDOT(t(n) + h/2, x(n) + kx1/2, y(n) + ky1/2);
   ky2 = h*YDOT(t(n) + h/2, x(n) + kx1/2, y(n) + ky1/2);
   
   kx3 = h*XDOT(t(n) + h/2, x(n) + kx2/2, y(n) + ky2/2);
   ky3 = h*YDOT(t(n) + h/2, x(n) + kx2/2, y(n) + ky2/2);
   
   kx4 = h*XDOT(t(n) + h,   x(n) + kx3,   y(n) + ky3);
   ky4 = h*YDOT(t(n) + h,   x(n) + kx3,   y(n) + ky3);
   
   x(n+1) = x(n) + (kx1+2*kx2+2*kx3+kx4)/6;
   y(n+1) = y(n) + (ky1+2*ky2+2*ky3+ky4)/6;
end




% xDOT & yDot variables (calls functions XDOT YDOT) 
%  xDot = XDOT(t,x(1),y(1));
%  yDot = YDOT(t,x(1),y(1));
 

% [2D] plots  =========================================================   
   Y = linspace(1,3,N);
  [tt, yy] = meshgrid(t,Y);
  YYDot = YDOT(tt,yy);
  
  
% GRAPHICS  ===========================================================
figure(1)
   set(gcf,'units','normalized');
   set(gcf,'position',[0.10 0.10 0.25 0.6]);
   set(gcf,'color','w');

subplot(3,1,1)
   xP = t; yP = x;
   plot(xP,yP,'b','linewidth',2)
   grid on
   xlabel('t')
   ylabel('x')
  % txt = sprintf('y = %3.1f  ',y(nY));
  % title(txt,'fontweight','normal')
   set(gca,'fontsize',12)
   
subplot(3,1,2)   
   yP = y;
   plot(xP,yP,'r','linewidth',2);
   xlabel('t')
   ylabel('y')
   grid on
   set(gca,'fontsize',12)
   
subplot(3,1,3)
   xP = x; yP = y;
   plot(xP,yP,'b','linewidth',2)
   hold on
   Hplot = plot(xP(1),yP(1),'go');
   set(Hplot,'markersize',8,'markerfacecolor','g')
   Hplot = plot(xP(N),yP(N),'ro');
   set(Hplot,'markersize',8,'markerfacecolor','r')
   grid on
   xlabel('x')
   ylabel('y')
  % txt = sprintf('y = %3.1f  ',y(nY));
  % title(txt,'fontweight','normal')
   set(gca,'fontsize',12)   
   
figure(2)
   set(gcf,'units','normalized');
   set(gcf,'position',[0.380 0.10 0.25 0.5]);
   set(gcf,'color','w');
   
subplot(2,1,1)
   pcolor(tt,yy,YYDot)
   shading interp
   colorbar
   title('dy / dt','fontweight','normal')
   xlabel('t')
   ylabel('y')
   set(gca,'fontsize',12)
 
 subplot(2,1,2)  
   surf(tt,yy,YYDot)
   shading interp
   colorbar
   title('dy / dt','fontweight','normal')
   xlabel('t')
   ylabel('y')
   set(gca,'fontsize',12)
   
   

