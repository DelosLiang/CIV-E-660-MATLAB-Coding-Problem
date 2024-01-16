function f_local=f_local_cal(disp_local,k_local)
% f_local_cal(disp_local,k_local) - This function determines element end forces in the local coordinate system.
%     
%     Input:
%     disp_local - Nodal displacements in local coordinate system.
%     k_local - Element stiffness matrix in local coordinate system.
%     
%     Output:
%     f_local - Element end forces in the local coordinate system.
%     
%     Author: Haoran Liang
%     Date: 27/11/2023
f_local=zeros(5,6);
for i=1:5
    for j=1:6
        f_int=k_local(:,:,i)*disp_local(i,:)';
        f_local(i,j)=f_int(j);
    end
end
end