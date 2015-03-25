%
% File name: bisection.m
%      Author: Suh-Yuh Yang at NCU
%         Date: February 22, 2011    
%
clear all;
clc;
format long 
a         = 1.0;  
b         = 2.0;
M        = 100;
delta    = 10^(-3);
epsilon = 10^(-5);
%
%
%
u = a^3 + 4.0*a^2 -10.0;
v = b^3 + 4.0*b^2 -10.0;
e = b - a; 
%
%
%
if sign(u) == sign(v)  
    display('The initial interval is not suitable!')
    break
end    
for k=1:1:M
    e  = e/2;
    c  = a+e;
    w = c^3 + 4.0*c^2 -10.0;
    [k, a, b, c, w]
    if abs(e) < delta & abs(w) < epsilon
        display('The approximate solution is obtained')  
        [k, a, b, c, w]
        break 
    end
    if sign(w) ~= sign(u)
        b = c;
        v = w;
    else
        a = c;
        u = w;        
    end
end