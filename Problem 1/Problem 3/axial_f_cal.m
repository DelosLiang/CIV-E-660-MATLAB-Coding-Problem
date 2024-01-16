function axial_f=axial_f_cal(disp_local,E,a,A)
% axial_f_cal(disp_local,E,a,A) - This function generates axial forces of each element.
%     
%     Input:
%     disp_local - Nodal displacements in local coordinate system.
%     E - Young's modulus.
%     A - cross-sectional area.
%     a - length of each bar.
%     
%     Output:
%     axial_f - Axial forces of each element.
% 
%     Author: Haoran Liang
%     Date: 04/10/2023
axial_f=zeros(9,1);
for i=1:7
    axial_f(i)=(disp_local(i,3)-disp_local(i,1))/a*E*A;
end
for i=8:9
    axial_f(i)=(disp_local(i,3)-disp_local(i,1))/(sqrt(2)*a)*E*A;
end
end