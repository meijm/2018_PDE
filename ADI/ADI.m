% Copyleft 2018 Jiaming Mei, Shanghaitech
clear all,clc,close all
%*************************initialize the condition
dt = 0.0005; dx = 0.05; dy = 0.04;

mux=dt/(dx)^2; muy=dt/(dy)^2;
mu=mux+muy;

Tf = 0.1; XR = 5; YS = 4;

xvals=0:dx:XR; yvals=0:dy:YS;
Lx=length(xvals); Ly=length(yvals);%note start from x0 to xr, length is r+1
%initial condition
U0=zeros(Ly,Lx);%the matrix y is in colum and x is in row
U0(floor(Lx/4):floor(3*Lx/4),floor(Ly/4):floor(3*Ly/4))=1;

%boundary condition
Boundary = @(x,y) 0;

%*********************set up the matrix
vx=ones(1,length(xvals)); vy=ones(1,length(yvals));
Ax=diag(-2*vx,0)+diag(vx(1:Lx-1),1)+diag(vx(1:Lx-1),-1);
Ay=diag(-2*vy,0)+diag(vy(1:Ly-1),1)+diag(vy(1:Ly-1),-1);

LB=inv((eye(Ly)-1/2*Ay))*(eye(Ly)+1/2*Ay);
RB=inv((eye(Lx)-1/2*Ax'))*(eye(Lx)+1/2*Ax');

%********************interate the time
Ut=U0;
figure
s = surf(xvals,yvals,U0);
axis manual% fix the axis

for t=0:dt:Tf
    Ut=LB*Ut*RB;
    Ut(1,:)=0; Ut(Ly,:)=0; Ut(:,1)=0; Ut(:,Lx)=0;%the boundary condtion by hand!
    s.ZData = Ut;
    
    pause(0.1)
end
close all