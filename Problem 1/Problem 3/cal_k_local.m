function k_local=cal_k_local(E,A,a)
% cal_k_local(E,A,a) - This function generates stiffness matrix for each element in local coordinate system.
%     
%     Input:
%     E - Young's modulus.
%     A - cross-sectional area.
%     a - length of each bar.
%     
%     Output:
%     k_local - Element stiffness matrix in local coordinate system.
% 
%     Author: Haoran Liang
%     Date: 04/10/2023
k_local=zeros(4,4,9);
for i=1:7
    k_local(:,:,i)=[1 0 -1 0;
        0 0 0 0;
        -1 0 1 0;
        0 0 0 0;];
end
for i=8:9
    k_local(:,:,i)=[1/sqrt(2) 0 -1/sqrt(2) 0;
        0 0 0 0;
        -1/sqrt(2) 0 1/sqrt(2) 0;
        0 0 0 0;];
end
k_local=k_local*(E*A/a);
end