function k=cal_k(E,A,a)
% cal_k(E,A,a) - This function generates stiffness matrix for each element in global coordinate system.
%     
%     Input:
%     E - Young's modulus.
%     A - cross-sectional area.
%     a - length of each bar.
%     
%     Output:
%     k - Element stiffness matrix in global coordinate system.
% 
%     Author: Haoran Liang
%     Date: 04/10/2023
k=zeros(4,4,9);
for i=4:7
    k(:,:,i)=[1 0 -1 0;
        0 0 0 0;
        -1 0 1 0;
        0 0 0 0;];
end
for i=1:3
    k(:,:,i)=[0 0 0 0;
        0 1 0 -1;
        0 0 0 0;
        0 -1 0 1];
end
k(:,:,8)=[1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2));
    -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
    -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
    1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2))];
k(:,:,9)=[1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
    1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
    -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2));
    -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2))];

k=k*(E*A/a);
end