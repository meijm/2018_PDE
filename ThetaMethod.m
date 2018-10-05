% Copyleft 2018 Jiaming Mei, Shanghaitech
% Source from Radu C. Cascaval, UCCS
%%
clear all, clc, clf
dt = 0.001;
dx = 0.05;
Tf=0.1;
N=floor(Tf/dt);

%initial conditions
u0 = @(x) 1-2*(x-1/2).*sign(x-1/2);

%Dirichlet boundary conditions
left = @(x) 0*x; %the left boundary condition
right = @(x) 0*x; %the right bondary conditon

%the mesh ratio
mu = dt/(dx^2);

tvals=0:dt:Tf;
xvals=0:dx:1;

J=length(xvals);
%Note: the original index j runs from j=1(x=0) to j=J(x=1)
%%
%Setup the scheme
%theta=0; explicit
%theta=1; implicit
%theta=1/2 Crank-Nicolson 
theta =1;
switch theta
    case 0
        scheme=' Explicit';
    case 1
        scheme=' Implicit';
    case 1/2
        scheme=' Crank-Nicolson';
    otherwise
        scheme=' the Theta';
end

u=zeros(J,N);
u(:,1)=u0(xvals);

E=ones(J ,1);
D=















 