function [e_nodes] = mesh_def(pt,n)
% mesh_def - This function defines the node number corresponding to each element.
%     
%     Input:
%     pt - pattern (1 for A, 2 for B)
%     n - number of spans
% 
%     Output:
%     [e_nodes] - Row represents element and column represents nodes of elements.
%     
%     Author: Haoran Liang
%     Date: 04/10/2023
e_nodes=zeros(4*n+1,2);
if pt==1
    for i=1:n+1
        e_nodes(i,1)=i;
        e_nodes(i,2)=n+1+i;
    end
    for i=n+2:2*n+1
        e_nodes(i,1)=i-n-1;
        e_nodes(i,2)=i-n;
    end
    for i=2*n+2:3*n+1
        e_nodes(i,1)=i-n;
        e_nodes(i,2)=i-n+1;
    end
    for i=3*n+2:7/2*n+1
        e_nodes(i,1)=i-3*n;
        e_nodes(i,2)=i-2*n;
    end
    for i=7/2*n+2:4*n+1
        e_nodes(i,1)=i-3*n-1;
        e_nodes(i,2)=i-2*n+1;
    end
end


if pt==2
    for i=1:n+1
        e_nodes(i,1)=i;
        e_nodes(i,2)=n+1+i;
    end
    for i=n+2:2*n+1
        e_nodes(i,1)=i-n-1;
        e_nodes(i,2)=i-n;
    end
    for i=2*n+2:3*n+1
        e_nodes(i,1)=i-n;
        e_nodes(i,2)=i-n+1;
    end
    for i=3*n+2:7/2*n+1
        e_nodes(i,1)=i-3*n-1;
        e_nodes(i,2)=i-2*n+1;
    end
    for i=7/2*n+2:4*n+1
        e_nodes(i,1)=i-3*n;
        e_nodes(i,2)=i-2*n;
    end
end
end