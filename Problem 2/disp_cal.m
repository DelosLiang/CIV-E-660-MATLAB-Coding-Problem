function disp_local=disp_cal(U,e_nodes)
% disp_cal(U,e_nodes) - This function determines nodal displacements of each element in the local coordinate system.
%     
%     Input:
%     U - Nodal displacements in global coordinate system.
%     e_nodes - Node number corresponding to each element.
%     
%     Output:
%     disp_local - Nodal displacements of each element in the local coordinate system.
%     
%     Author: Haoran Liang
%     Date: 27/11/2023
disp_local=zeros(5,6);
disp_global=zeros(5,6);% nodal displacements of each element in the global coordinate system.
for i=1:5
    for j=1:3
        disp_global(i,j)=U((e_nodes(i,1)-1)*3+j);
    end
    for j=1:3
        disp_global(i,j+3)=U((e_nodes(i,2)-1)*3+j);
    end
end
for i=[1]
    disp_local(i,:)=(trans(pi/2)*disp_global(i,:)')';
end

for i=2:4
    disp_local(i,:)=disp_global(i,:);
end
for i=[5]
    disp_local(i,:)=(trans(3*pi/2)*disp_global(i,:)')';
end
end


