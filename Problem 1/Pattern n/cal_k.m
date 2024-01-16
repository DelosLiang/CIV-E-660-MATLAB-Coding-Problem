function k=cal_k(E,A,a,n,ne,pt)
% cal_k(E,A,a,n,ne,pt) - This function generates stiffness matrix for each element in global coordinate system.
%     
%     Input:
%     E - Young's modulus.
%     A - cross-sectional area.
%     a - length of each bar.
%     n - number of spans
%     ne - number of elements
%     pt - pattern (1 for A, 2 for B)
%     
%     Output:
%     k - Element stiffness matrix in global coordinate system.
% 
%     Author: Haoran Liang
%     Date: 04/10/2023
k=zeros(4,4,ne);
for i=1:n+1
    k(:,:,i)=[0 0 0 0;
        0 1 0 -1;
        0 0 0 0;
        0 -1 0 1];
end
for i=n+2:3*n+1
    k(:,:,i)=[1 0 -1 0;
        0 0 0 0;
        -1 0 1 0;
        0 0 0 0;];
end
if pt==1
    for i=3*n+2:7/2*n+1
    k(:,:,i)=[1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2));
        -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
        -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
        1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2))];
    end
    for i=7/2*n+2:4*n+1
    k(:,:,i)=[1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
        1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
        -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2));
        -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2))];
    end
end
if pt==2
    for i=3*n+2:7/2*n+1
    k(:,:,i)=[1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
        1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2));
        -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2));
        -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2))];
    end
    for i=7/2*n+2:4*n+1
        k(:,:,i)=[1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2));
        -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
        -1/(2*sqrt(2)) 1/(2*sqrt(2)) 1/(2*sqrt(2)) -1/(2*sqrt(2));
        1/(2*sqrt(2)) -1/(2*sqrt(2)) -1/(2*sqrt(2)) 1/(2*sqrt(2))];
    end
end
k=k*(E*A/a);
end