clear; clc

f1=@(t,x)sin(t)-2.*x;
[t,x]= ode45(@f2,[0,2],0);
plot(t,x)

function dxdt = f2(t,x)
dxdt = sin(t)-2.*x;
end