% Copyleft 2018 Jiaming Mei, Shanghaitech
% Source from Radu C. Cascaval, UCCS
%%
%*********************************initial conditions**********************
clear all, clc, close all
dt = 0.001;
dx = 0.05;
Tf=0.1;

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
N=length(tvals);
%Note: the original index j runs from j=1(x=0) to j=J(x=1)
%%
%*********************************Setup the scheme************************
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

u=zeros(J,N);%the first colum is t=0,X-axis is T, Y-axis is x
u(:,1)=u0(xvals);

E=ones(J ,1);
D=spdiags([-E 2*E -E],[-1,0,1],J,J);%create J*J matrix and repalce with..
%full convert sparse to dense
I=speye(J);%sparse eye

A=I+theta*mu*D;%super intelligent method to construct A and B with D!!!!!!!
B=I-(1-theta)*mu*D;

A(1,:)=0;A(1,1)=1;%consider the boundary condition
A(J,:)=0;A(J,J)=1;

[L,U]=lu(A);%LU matrix factorization
%%
%********************************time iteration****************************
for n=1:N-1
    rhs=B*u(:,n);
    rhs([1,J])=0;%the boundary condition is zero
    y=L\rhs;
    u(:,n+1)=U\y;
end
for t=1:10:N
    u_t=u(:,t);
    plot(xvals,u_t,'-o');
    hold on
end
hold off
figure

%surf(xvals,tvals,u')
[X,Y]=meshgrid(xvals,tvals);
surf(X,Y,u');
xlabel('x')
ylabel('t')
zlabel('u')

















 