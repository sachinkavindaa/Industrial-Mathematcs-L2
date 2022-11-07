clear all
close all
clc

n=100;
r=0.1;

load path.mat;

x=D(:,1);
y=D(:,2);


figure(1);
plot(x(1:end),y(1:end),'r','linewidth',2)
ylabel('y-axis,horizontal position')
xlabel('x-axis,vertical position')
title('Vertical position and horizontl position')
grid on;


figure(2)
plot(-3,0,'r.');
hold on 
plot(0,-3,'r.');
plot(3,0,'r.');
plot(0,3,'r.');
axis tight

for j = 1:length(x)
    
    [x1,y1] = sp1(0,-3,x(j),y(j),n,r);
    h=plot(x1,y1,'k-','LineWidth',2);
    hold on
    
    [x2,y2] = sp1(0,3,x(j),y(j),n,r);
    h=plot(x2,y2,'k-','LineWidth',2);
    
    [x3,y3] = sp1(-3,0,x(j),y(j),n,r);
    h=plot(x3,y3,'k-','LineWidth',2);
    
    [x4,y4] = sp1(3,0,x(j),y(j),n,r);
    h=plot(x4,y4,'k-','LineWidth',2);
    
    plot(-3,0,'r.');
    plot(0,-3,'r.');
    plot(3,0,'r.');
    plot(0,3,'r.');
    
    h=plot(x(j),y(j),'--rs','LineWidth',2,'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',30);
            grid on
	drawnow
    %pause(0.005);
	delete(h)
	hold off
end


% figure(1)
% [x_new,y_new] = sp1(0,-3,1,1,n,r);
% plot(x_new,y_new,'r-');
% 
% hold on 
% 
% [x_new,y_new] = sp1(0,3,1,1,n,r);
% plot(x_new,y_new,'r-');
% 
% [x_new,y_new] = sp1(-3,0,1,1,n,r);
% plot(x_new,y_new,'r-');
% 
% [x_new,y_new] = sp1(3,0,1,1,n,r);
% plot(x_new,y_new,'r-');
% 
% grid on
% hold off