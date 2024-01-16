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
%     Date: 04/10/2023
disp_local=zeros(9,4);
disp_global=zeros(9,4);% nodal displacements of each element in the global coordinate system.
for i=1:9
    for j=1:4
        if mod(j,2)~=0
            disp_global(i,j)=U(e_nodes(i,(j+1)/2)*2-1);
        else
            disp_global(i,j)=U(e_nodes(i,j/2)*2);
        end
    end
end
for i=4:7
    for j=1:4
        disp_int=trans(0)*disp_global(i,:)';
        disp_local(i,j)=disp_int(j);
    end
end
for i=1:3
    for j=1:4
        disp_int=trans(pi/2)*disp_global(i,:)';
        disp_local(i,j)=disp_int(j);
    end
end
disp_int=trans(3*pi/4)*disp_global(8,:)';
for j=1:4
    disp_local(8,j)=disp_int(j);
end
disp_int=trans(pi/4)*disp_global(9,:)';
for j=1:4
    disp_local(9,j)=disp_int(j);
end
end