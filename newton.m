%
% File name: newton.m
%      Author: Suh-Yuh Yang at NCU
%         Date: March 08, 2011    
%
clc;
clear all;
format long 
p0        = pi/4; 
M         = 100;
delta     = 10^(-12);
epsilon   = 10^(-12);
v         = cos(p0) - p0; 
[0, p0, v] 
%
%
%
if abs(v) < epsilon  
    display('The approximate solution is obtained')
    [0, p0, v] 
    break
end    
for k=1:1:M
    p1 = p0 - v/(- sin(p0)-1);
    v   = cos(p1) - p1;
    [k, p1, v]
    if abs(p1-p0) < delta | abs(v) < epsilon
        display('The approximate solution is obtained')  
        [k, p1, v]
        break 
    else
        p0 = p1;         
    end
end