function [e_nodes] = mesh_def()
% mesh_def - This function defines the node number corresponding to each element.
%     
%     Output:
%     [e_nodes] - Row represents element and column represents nodes of elements.
%     
%     Author: Haoran Liang
%     Date: 04/10/2023
e_nodes=[1 4;
    2 5;
    3 6;
    4 5;
    5 6;
    1 2;
    2 3;
    2 4;
    2 6];
end