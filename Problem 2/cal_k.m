function k=cal_k(k_local)
% cal_k(E,A,a) - This function generates stiffness matrix for each element in global coordinate system.
%     
%     Input:
%     k_local - Element stiffness matrix in local coordinate system.
%     
%     Output:
%     k - Element stiffness matrix in global coordinate system.
% 
%     Author: Haoran Liang
%     Date: 28/11/2023
k=zeros(6,6,5);
for i=[1]
    k(:,:,i)=trans(pi/2)'*k_local(:,:,i)*trans(pi/2);
end
for i=2:4
    k(:,:,i)=k_local(:,:,i);
end
for i=[5]
    k(:,:,i)=trans(3*pi/2)'*k_local(:,:,i)*trans(3*pi/2);
end
end