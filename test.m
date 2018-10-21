clc,clear,close all
%review the plot tech
[X,Y] = meshgrid(1:0.5:10,1:20);
Z = sin(X) + cos(Y);
C = X.*Y;
surf(X,Y,Z,C)
colorbar
xlabel('x')
ylabel('y')
zlabel('z')
title('test figure')
axis([0 20 0 30 -2 2])
figure
surf(X,Y,Z,C)
hold on
Z2=peaks;
surf(Z2)
hold off
figure
A=[1 2 3 4;
   2 3 4 5;
   6 6 6 6;]
plot(A)
F=getframe;
figure
imshow(F.cdata)
figure
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';


loops = 40;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    F(j) = getframe;
end