%
% File name: secant.m
%      Author: Suh-Yuh Yang at NCU
%         Date: March 13, 2011  
%
clear all;
format long 
M         = 100;
delta     = 10^(-12);
epsilon = 10^(-12);
x0        = 0.5; 
v          = cos(x0)- x0; 
[0, x0, v]
x1         = pi/4.0;
w          = cos(x1)- x1; 
[1, x1, w]
%
%
%
if abs(w) < epsilon  
    display('The approximate is obtained')
    x1 
    break
end    
for k=2:1:M
    derivative = (w-v)/(x1- x0);
    x0 = x1;
    v = cos(x0)- x0; 
    x1 = x1 - w/derivative;
    w   = cos(x1)- x1;
    [k, x1, w]
    if abs(x1-x0) < delta | abs(w) < epsilon
        display('The approximate solution is obtained')  
        [k, x1, w]
        break     
    end
end