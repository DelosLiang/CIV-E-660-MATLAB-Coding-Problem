clc
clear
close all
%% Problem 3
% Background: When an engineer wants to design a truss structure for a 
% bridge or joist, the truss members can be arranged in different patterns.
%% Parameters configuration
ne=9;% number of elements
nnodes=6;% number of nodes
E=29000E9;% Young's modulus
a=5;% length of each bar
A=0.0004;% cross-sectional area
p=10E3;% magnitude of load
%% Define the concentrated force boundary [node number, force, dimension of DOF](vertical direction）
force=[4, -p, 2;
    5, -p, 2;
    6, -p, 2];
%% Generate the node number corresponding to each element
[e_nodes] = mesh_def(); 
%% The concentrated force boundary is introduced to calculate F
P=zeros(2*nnodes,1);
for i=1:size(force,1)
    P(force(i,1)*2)=force(i,2);
end
%% Calculate element stiffness matrix k
k_local=cal_k_local(E,A,a);% k in local coordinate system
k=cal_k(E,A,a);% k in global coordinate system
%% Assemble global stiffness matrix K(ID array approach)
K=zeros(nnodes*2);
for i=1:ne
    K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)=K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)+k(1:2,1:2,i);
    K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)=K(e_nodes(i,1)*2-1:e_nodes(i,1)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)+k(1:2,3:4,i);
    K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)=K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,1)*2-1:e_nodes(i,1)*2)+k(3:4,1:2,i);
    K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)=K(e_nodes(i,2)*2-1:e_nodes(i,2)*2,e_nodes(i,2)*2-1:e_nodes(i,2)*2)+k(3:4,3:4,i);
end
K_exp=K;% expansion of global stiffness matrix
%% Diagonal elements change 1 to introduce displacement boundary
% Displacement boundary:
% 1.At the node #1 ux，uy = 0
K(1*2-1,:)=0;
K(:,1*2-1)=0;
K(1*2-1,1*2-1)=1;
P(1*2-1)=0;

K(1*2,:)=0;
K(:,1*2)=0;
K(1*2,1*2)=1;
P(1*2)=0;

% 2.At the node #3 uy=0
K(3*2,:)=0;
K(:,3*2)=0;
K(3*2,3*2)=1;
P(3*2)=0;
%% Solve for KU=P, to generate the nodal displacements in the global coordinate system
U=K\P;
%% Determine nodal displacements of each element in the local coordinate system
fprintf('The nodal displacements of each element in the local coordinate system :')
disp_local=disp_cal(U,e_nodes)
%% Determine the element end forces in the local and global coordinate system
fprintf('The element end forces in the local coordinate system :')
f_local=f_local_cal(disp_local,k_local)
fprintf('The element end forces in the global coordinate system :')
f_global=f_global_cal(f_local)
%% Determine the reaction forces of support 1 and 3
F_reaction=K_exp*U;
fprintf('The reaction forces of support 1 :')
reaction_force_1_x=F_reaction(1*2-1)
reaction_force_1_y=F_reaction(1*2)
fprintf('The reaction forces of support 3 :')
reaction_force_3_y=F_reaction(3*2)
%% Determine axial forces of each element
fprintf('The axial forces of each element :')
axial_f=axial_f_cal(disp_local,E,a,A)
%% Plot the axial force diagram
U_update=zeros(6,2);
for i=1:12
    if mod(i,2)~=0
        U_update((i+1)/2,1)=U(i);
    else
        U_update(i/2,2)=U(i);
    end
end
[position]=mesh_plot();% coordinates of each node
U_deform=position+U_update*2E4;% for better visualization, the deformation is enlarged 2E4 times.
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=1:9
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2,'Color','black','LineStyle','-');
    hold on
end
hold on
i=1;
x = [0 0 -axial_f(i)*5e-5 -axial_f(i)*5e-5 0];
y = [0 5 5 0 0] ;
fill( x, y, [ 0, 0, 1 ])
i=2;
x = [5 5 5-axial_f(i)*5e-5 5-axial_f(i)*5e-5 5];
y = [0 5 5 0 0] ;
fill( x, y, [ 0, 1, 1 ])
i=3;
x = [10 10 10-axial_f(i)*5e-5 10-axial_f(i)*5e-5 10];
y = [0 5 5 0 0] ;
fill( x, y, [ 0, 0, 1 ] )
i=4;
x=[0 0 5 5 0];
y=[5+axial_f(i)*5e-5 5 5 5+axial_f(i)*5e-5 5+axial_f(i)*5e-5];
fill( x, y, [ 0, 1, 0 ])
i=5;
x=[5 5 10 10 5];
y=[5+axial_f(i)*5e-5 5 5 5+axial_f(i)*5e-5 5+axial_f(i)*5e-5];
fill( x, y, [ 0, 1, 0 ])
i=8;
x=[-axial_f(i)*5e-5/sqrt(2) 0 5 5-axial_f(i)*5e-5/sqrt(2) -axial_f(i)*5e-5/sqrt(2)];
y=[5-axial_f(i)*5e-5/sqrt(2) 5 0 -axial_f(i)*5e-5/sqrt(2) 5-axial_f(i)*5e-5/sqrt(2)];
fill( x, y, [ 1, 0, 0 ])
i=9;
x=[5-axial_f(i)*5e-5/sqrt(2) 10-axial_f(i)*5e-5/sqrt(2) 10 5 5-axial_f(i)*5e-5/sqrt(2)];
y=[axial_f(i)*5e-5/sqrt(2) 5+axial_f(i)*5e-5/sqrt(2) 5 0 axial_f(i)*5e-5/sqrt(2)];
fill( x, y, [ 1, 0, 0 ])

colorbar('Ticks',[0,0.22654,0.45308,0.67962,1],...
         'TickLabels',{'-15000','-10000','-5000','0','7071.07'})
colormap(jet)
title('Axial force diagram', 'FontSize',16)
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-2 12])
ylim([-1 6])
%% Plot the deformed truss structure with the undeformed structure as background
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=1:9
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2,'Color','red','LineStyle','-');
    hold on
end
for i=1:6
    plot(U_deform(i,1),U_deform(i,2),'bo');
    hold on
end
for i=1:9
    line([U_deform(e_nodes(i,1),1),U_deform(e_nodes(i,2),1)],[U_deform(e_nodes(i,1),2),U_deform(e_nodes(i,2),2)],'LineWidth',1,'Color','blue','LineStyle','--');
    hold on
end
title('Deformed truss structure ','FontSize',16)
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-1 11])
ylim([-1 6])