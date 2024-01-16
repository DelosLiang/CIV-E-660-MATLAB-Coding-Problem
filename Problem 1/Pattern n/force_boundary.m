function [force]=force_boundary(n,p)
% force_boundary(n,p) - This function returns force array.
%     
%     Input:
%     n - Number of spans.
%     p - Magnitude of load.
%     
%     Output:
%     [force] - force array.
% 
%     Author: Haoran Liang
%     Date: 04/10/2023
force=zeros(n+1,3);
for i=1:n+1
    force(i,1)=n+1+i;% node number
    force(i,2)=-p;% force
    force(i,3)=2;% dimension of DOF
end