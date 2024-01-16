clc
clear all
close all
%% Parameters configuration
ne=5;% number of elements
nnodes=6;% number of nodes
P=100;% value of concentrate load
E=4757;% Young's modulus
Iw=2.15e7;% polar moment of inertia
Ib=11295;% polar moment of inertia
W=10*12;% length (in)
H=10*12;% height (in)
Aw=3396;% cross-sectional area
Ab=1000;% cross-sectional area
beta=0.05;% coefficient regarding rigid beam
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
K_exp=K;% expansion of global stiffness matrix
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
%% Determine nodal displacements of each element in the local coordinate system
fprintf('The nodal displacements of each element in the local coordinate system :')
disp_local=disp_cal(U,e_nodes)
%% Determine the element end forces in the local and global coordinate system
fprintf('The element end forces in the local coordinate system :')
f_local=f_local_cal(disp_local,k_local)
fprintf('The element end forces in the global coordinate system :')
f_global=f_global_cal(f_local)
%% Determine the reaction forces of support 1 and 6
F_reaction=K_exp*U;
fprintf('The reaction forces of support 1 :')
reaction_force_1_x=F_reaction(1*3-2)
reaction_force_1_y=F_reaction(1*3-1)
reaction_force_1_moment=F_reaction(1*3)
fprintf('The reaction forces of support 6 :')
reaction_force_6_x=F_reaction(6*3-2)
reaction_force_6_y=F_reaction(6*3-1)
reaction_force_6_moment=F_reaction(6*3)
%% Plot the axial force diagram
U_update=zeros(6,3);
for i=1:18
    if mod(i,3)==1
        U_update((i+2)/3,1)=U(i);
    end
    if mod(i,3)==2
            U_update((i+1)/3,2)=U(i);
    end
    if mod(i,3)==0
            U_update(i/3,3)=U(i);
    end
end
[position]=mesh_plot_ex();% coordinates of each node
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=[1 3 5]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',1.5,'Color','black','LineStyle','-');
    hold on
end
for i=[2 4]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2.5,'Color','black','LineStyle','-');
    hold on
end
line([-20,0],[0,0],'LineWidth',1,'Color','red','LineStyle','-');
line([-20,-20],[0,180],'LineWidth',1,'Color','red','LineStyle','-');
line([-20,0],[180,180],'LineWidth',1,'Color','red','LineStyle','-');
text(-12,90,'+','Color','red','FontSize',16);
text(5,90,'0.03','Color','red','FontSize',16);
line([0,36],[130,130],'LineWidth',1,'Color','blue','LineStyle','-');
line([36,36],[130,180],'LineWidth',1,'Color','blue','LineStyle','-');
text(15,155,'-','Color','blue','FontSize',16);
text(5,120,'15.04','Color','blue','FontSize',16);
line([36,396],[130,130],'LineWidth',1,'Color','blue','LineStyle','-');
line([396,396],[130,180],'LineWidth',1,'Color','blue','LineStyle','-');
text(216,155,'-','Color','blue','FontSize',16);
text(205,120,'15.04','Color','blue','FontSize',16);
line([396,432],[130,130],'LineWidth',1,'Color','blue','LineStyle','-');
text(414,155,'-','Color','blue','FontSize',16);
text(440,155,'15.04','Color','blue','FontSize',16);
line([412,432],[0,0],'LineWidth',1,'Color','blue','LineStyle','-');
line([412,412],[0,180],'LineWidth',1,'Color','blue','LineStyle','-');
text(420,90,'-','Color','blue','FontSize',16);
text(390,90,'0.03','Color','blue','FontSize',16);
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-60 490])
ylim([-20 220])
title('Axial force diagram ','FontSize',16)
xlabel('Unit:kips','FontSize',16)
%% Plot the shear force diagram
U_update=zeros(6,3);
for i=1:18
    if mod(i,3)==1
        U_update((i+2)/3,1)=U(i);
    end
    if mod(i,3)==2
            U_update((i+1)/3,2)=U(i);
    end
    if mod(i,3)==0
            U_update(i/3,3)=U(i);
    end
end
[position]=mesh_plot_ex();% coordinates of each node
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=[1 3 5]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',1.5,'Color','black','LineStyle','-');
    hold on
end
for i=[2 4]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2.5,'Color','black','LineStyle','-');
    hold on
end
line([50,0],[0,0],'LineWidth',1,'Color','blue','LineStyle','-');
line([50,50],[0,180],'LineWidth',1,'Color','blue','LineStyle','-');
line([50,0],[180,180],'LineWidth',1,'Color','blue','LineStyle','-');
text(25,90,'-','Color','blue','FontSize',16);
text(55,90,'84.96','Color','blue','FontSize',16);
line([0,0],[180,200],'LineWidth',1,'Color','red','LineStyle','-');
line([0,36],[200,200],'LineWidth',1,'Color','red','LineStyle','-');
line([36,36],[180,200],'LineWidth',1,'Color','red','LineStyle','-');
text(15,190,'+','Color','red','FontSize',16);
text(10,205,'0.03','Color','red','FontSize',16);
line([36,396],[200,200],'LineWidth',1,'Color','red','LineStyle','-');
line([396,396],[180,200],'LineWidth',1,'Color','red','LineStyle','-');
text(216,190,'+','Color','red','FontSize',16);
text(210,205,'0.03','Color','red','FontSize',16);
line([396,432],[200,200],'LineWidth',1,'Color','red','LineStyle','-');
line([432,432],[180,200],'LineWidth',1,'Color','red','LineStyle','-');
text(414,190,'+','Color','red','FontSize',16);
text(408,205,'0.03','Color','red','FontSize',16);
line([405,432],[0,0],'LineWidth',1,'Color','blue','LineStyle','-');
line([405,405],[0,180],'LineWidth',1,'Color','blue','LineStyle','-');
text(416,90,'-','Color','blue','FontSize',16);
text(375,90,'15.04','Color','blue','FontSize',16);
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-60 490])
ylim([-20 220])
title('Shear force diagram ','FontSize',16)
xlabel('Unit:kips','FontSize',16)
%% Plot the bending moment diagram
U_update=zeros(6,3);
for i=1:18
    if mod(i,3)==1
        U_update((i+2)/3,1)=U(i);
    end
    if mod(i,3)==2
            U_update((i+1)/3,2)=U(i);
    end
    if mod(i,3)==0
            U_update(i/3,3)=U(i);
    end
end
[position]=mesh_plot_ex();% coordinates of each node
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=[1 3 5]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',1.5,'Color','black','LineStyle','-');
    hold on
end
for i=[2 4]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2.5,'Color','black','LineStyle','-');
    hold on
end
line([-80,0],[0,0],'LineWidth',1,'Color','red','LineStyle','-');
line([-80,20],[0,180],'LineWidth',1,'Color','red','LineStyle','-');
text(-60,-10,'15284.07','Color','red','FontSize',16);
text(0,190,'7.84','Color','red','FontSize',16);
line([0,36],[160,165],'LineWidth',1,'Color','red','LineStyle','-');
line([36,36],[165,180],'LineWidth',1,'Color','red','LineStyle','-');
text(-25,160,'7.84','Color','red','FontSize',16);
text(36,160,'7.66','Color','red','FontSize',16);
line([36,396],[165,190],'LineWidth',1,'Color','red','LineStyle','-');
line([396,396],[180,190],'LineWidth',1,'Color','red','LineStyle','-');
text(396,200,'4.83','Color','red','FontSize',16);
line([396,432],[190,195],'LineWidth',1,'Color','red','LineStyle','-');
line([432,432],[180,195],'LineWidth',1,'Color','red','LineStyle','-');
text(432,200,'5.00','Color','red','FontSize',16);
line([432,447],[180,180],'LineWidth',1,'Color','red','LineStyle','-');
line([447,395],[180,0],'LineWidth',1,'Color','red','LineStyle','-');
line([395,432],[0,0],'LineWidth',1,'Color','red','LineStyle','-');
text(450,180,'5.00','Color','red','FontSize',16);
text(395,-10,'2703.07','Color','red','FontSize',16);
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-100 530])
ylim([-20 220])
title('Bending moment diagram ','FontSize',16)
xlabel('Unit:kips·in','FontSize',16)
%% Plot the deformed truss structure with the undeformed structure as background
U_update=zeros(6,3);
for i=1:18
    if mod(i,3)==1
        U_update((i+2)/3,1)=U(i);
    end
    if mod(i,3)==2
            U_update((i+1)/3,2)=U(i);
    end
    if mod(i,3)==0
            U_update(i/3,3)=U(i);
    end
end
[position]=mesh_plot();% coordinates of each node
U_deform=position+U_update(:,1:2)*3E4;% for better visualization, the deformation is enlarged 3E4 times.
figure
for i=1:6
    plot(position(i,1),position(i,2),'ro');
    hold on
end
for i=[1 3 5]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',1.5,'Color','red','LineStyle','-');
    hold on
end
for i=[2 4]
    line([position(e_nodes(i,1),1),position(e_nodes(i,2),1)],[position(e_nodes(i,1),2),position(e_nodes(i,2),2)],'LineWidth',2.5,'Color','red','LineStyle','-');
    hold on
end
for i=1:6
    plot(U_deform(i,1),U_deform(i,2),'bo');
    hold on
end
for i=[2 4]
    line([U_deform(e_nodes(i,1),1),U_deform(e_nodes(i,2),1)],[U_deform(e_nodes(i,1),2),U_deform(e_nodes(i,2),2)],'LineWidth',2,'Color','blue','LineStyle','--');
    hold on
end
x_1 = [0 0.0001387 0.0002391 0.0005043 0.0008367 0.0010211 0.0016135]*3E4;
y_1 = [0 0.0000001 0.0000001 0.0000002 0.0000002 0.0000002 0.0000003]*3E4;
CA=[0 1/4 1/3 1/2 2/3 3/4 1]*180;
y_1=y_1+CA;
p_1 = polyfit(x_1,y_1,2);
x_1_1 = linspace(0,0.0016135*3E4);
y_1_1 = polyval(p_1,x_1_1);
plot(x_1_1,y_1_1,'LineWidth',1,'Color','blue','LineStyle','--')
x_2 = [0.0016135 0.0012814 0.0011707 0.0009493 0.0007279 0.0006172 0.0002852]*3E4;
y_2 = [-0.0000803 -0.0008128 -0.0008184 -0.0006143 -0.0002810 -0.0001252 0.0000139]*3E4+180;
EF=[0 1/4 1/3 1/2 2/3 3/4 1]*420+6;
x_2=x_2+EF;
p_2 = polyfit(x_2,y_2,3);
x_2_2 = linspace(x_2(1),x_2(7),100);
y_2_2 = polyval(p_2,x_2_2);
plot(x_2_2,y_2_2,'LineWidth',1,'Color','blue','LineStyle','--')
x_3 = [0.0002852 0.0001805 0.0001479 0.0000892 0.0000423 0.0000245 0.0000000]*3E4+432;
y_3 = [-0.0000003 -0.0000002 -0.0000002 -0.0000002 -0.0000001 -0.0000001 0.0000000]*3E4;
BD=180-[0 1/4 1/3 1/2 2/3 3/4 1]*180;
y_3=y_3+BD;
p_3 = polyfit(x_3,y_3,2);
x_3_3 = linspace(x_3(1),x_3(7));
y_3_3 = polyval(p_3,x_3_3);
plot(x_3_3,y_3_3,'LineWidth',1,'Color','blue','LineStyle','--')
title('Deformed frame structure ','FontSize',16)
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'xticklabel',[])
xlim([-20 450])
ylim([-20 200])