function T=trans(phi)
% trans(phi) - This function defines transformation matrix for an element-end displacement vector from a global coordinate system to local coordinate system.
%     
%     Input:
%     phi - Angle of rotation.
%     
%     Output:
%     T - Transformation matrix.
%     
%     Author: Haoran Liang
%     Date: 04/10/2023
T=[cos(phi) sin(phi) 0 0;
    -sin(phi) cos(phi) 0 0;
    0 0 cos(phi) sin(phi);
    0 0 -sin(phi) cos(phi)];
end