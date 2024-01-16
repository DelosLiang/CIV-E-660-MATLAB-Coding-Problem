function U_out=ugenerator(beta)
%% This function returns the displacement at A when β takes different values.
%% Parameters configuration
ne=5;% number of elements
nnodes=6;% number of nodes
P=100;% concentrate load
E=4757;% Young's modulus
Iw=2.15e7;% polar moment of inertia
Ib=11295;% polar moment of inertia
W=10*12;% length (in)
H=10*12;% height (in)
Aw=3396;% cross-sectional area
Ab=1000;% cross-sectional area
%% Define the concentrated force boundary [node number, force, dimension of DOF]
force=[2, P, 1];
%% Generate the node number corresponding to each element
[e_nodes] = mesh_def(); 
%% The concentrated force boundary is introduced to calculate F
P=zeros(3*nnodes,1);
for i=1:size(force,1)
    P(force(i,1)*3-2)=force(i,2);
end
%% Calculate element stiffness matrix k
k_local=cal_k_local(E,Iw,Ib,Aw,Ab,W,H,beta);% k in local coordinate system
k=cal_k(k_local);% k in global coordinate system
%% Assemble global stiffness matrix K(ID array approach)
K=zeros(nnodes*3);
for i=1:ne
    K(e_nodes(i,1)*3-2:e_nodes(i,1)*3,e_nodes(i,1)*3-2:e_nodes(i,1)*3)=K(e_nodes(i,1)*3-2:e_nodes(i,1)*3,e_nodes(i,1)*3-2:e_nodes(i,1)*3)+k(1:3,1:3,i);
    K(e_nodes(i,1)*3-2:e_nodes(i,1)*3,e_nodes(i,2)*3-2:e_nodes(i,2)*3)=K(e_nodes(i,1)*3-2:e_nodes(i,1)*3,e_nodes(i,2)*3-2:e_nodes(i,2)*3)+k(1:3,4:6,i);
    K(e_nodes(i,2)*3-2:e_nodes(i,2)*3,e_nodes(i,1)*3-2:e_nodes(i,1)*3)=K(e_nodes(i,2)*3-2:e_nodes(i,2)*3,e_nodes(i,1)*3-2:e_nodes(i,1)*3)+k(4:6,1:3,i);
    K(e_nodes(i,2)*3-2:e_nodes(i,2)*3,e_nodes(i,2)*3-2:e_nodes(i,2)*3)=K(e_nodes(i,2)*3-2:e_nodes(i,2)*3,e_nodes(i,2)*3-2:e_nodes(i,2)*3)+k(4:6,4:6,i);
end
%% Diagonal elements change 1 to introduce displacement boundary
% Displacement boundary:
% 1.At the node #1 ux，uy, theta = 0
K(1*3-2,:)=0;
K(:,1*3-2)=0;
K(1*3-2,1*3-2)=1;
P(1*3-2)=0;
K(1*3-1,:)=0;
K(:,1*3-1)=0;
K(1*3-1,1*3-1)=1;
P(1*3-1)=0;
K(1*3,:)=0;
K(:,1*3)=0;
K(1*3,1*3)=1;
P(1*3)=0;
% 2.At the node #6 ux，uy, theta = 0
K(6*3-2,:)=0;
K(:,6*3-2)=0;
K(6*3-2,6*3-2)=1;
P(6*3-2)=0;
K(6*3-1,:)=0;
K(:,6*3-1)=0;
K(6*3-1,6*3-1)=1;
P(6*3-1)=0;
K(6*3,:)=0;
K(:,6*3)=0;
K(6*3,6*3)=1;
P(6*3)=0;
%% Solve for KU=P, to generate the nodal displacements in the global coordinate system
U=K\P;
U_out=zeros(2,1);
U_out(1,1)=U(4);
U_out(2,1)=U(5);
end