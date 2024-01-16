function [position]=mesh_plot()
% mesh_plot() - This function stores coordinates of each node.
%     
%     Output:
%     position - Coordinates of each node.
% 
%     Author: Haoran Liang
%     Date: 28/11/2023
position=[0 0;
    0 1.5*10*12;
    0.05*10*12 1.5*10*12;
    3.6*10*12-0.05*10*12 1.5*10*12;
    3.6*10*12 1.5*10*12;
    3.6*10*12 0];
end