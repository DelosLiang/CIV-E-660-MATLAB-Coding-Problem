clc
clear
close all
%% Problem 3
% Background: When an engineer wants to design a truss structure for a 
% bridge or joist, the truss members can be arranged in different patterns.
%% Parameters configuration
n=4;% number of spans (2, 4, 6, 8, 10, etc.)
ne=4*n+1;% number of elements
nnodes=2*n+2;% number of nodes
E=29000E9;% Young's modulus
a=5;% length of each bar
A=0.0004;% cross-sectional area
p=10E3;% magnitude of load
pt=1;% Pattern of truss structure(1 for A and 2 for B)
%% Define the concentrated force boundary [node number, force, dimension of DOF](vertical direction）
[force]=force_boundary(n,p);
%% Generate the node number corresponding to each element
[e_nodes] = mesh_def(pt,n); 
%% The concentrated force boundary is introduced to calculate F
P=zeros(2*nnodes,1);
for i=1:size(force,1)
    P(force(i,1)*2)=force(i,2);
end
%% Calculate element stiffness matrix k
k=cal_k(E,A,a,n,ne,pt);
%% Assemble global stiffness matrix K
K=zeros(nnodes*2);
for i=1:ne
    K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)=K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)+k(1:2,1:2,i);
    K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)=K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)+k(1:2,3:4,i);
    K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)=K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)+k(3:4,1:2,i);
    K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)=K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)+k(3:4,3:4,i);
end
%% Diagonal elements change 1 to introduce displacement boundary
%Displacement boundary:
%1.At the node #1 ux，uy = 0
K(1*2-1,:)=0;
K(:,1*2-1)=0;
K(1*2-1,1*2-1)=1;
P(1*2-1)=0;

K(1*2,:)=0;
K(:,1*2)=0;
K(1*2,1*2)=1;
P(1*2)=0;

%2.At the node #n+1 uy=0
K((n+1)*2,:)=0;
K(:,(n+1)*2)=0;
K((n+1)*2,(n+1)*2)=1;
P((n+1)*2)=0;
%% Solve for KU=P, to generate U
U=K\P;
%% Print the the deformation at the bottom node located at the middle span of the truss structure
fprintf('The deformation is :%.3d m\n',U(n+2))