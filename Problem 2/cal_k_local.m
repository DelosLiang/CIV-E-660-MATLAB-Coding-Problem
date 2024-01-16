function k=cal_k_local(E,Iw,Ib,Aw,Ab,W,H,beta)
% cal_k_local(E,A,a) - This function generates stiffness matrix for each element in local coordinate system.
%     
%     Input:
%     E - Young's modulus.
%     Aw, Ab - cross-sectional area.
%     Iw, Ib - polar moment of inertia.
%     W, H - unit length.
%     beta - coefficient regarding rigid beam
%
%     Output:
%     k - Element stiffness matrix in local coordinate system.
% 
%     Author: Haoran Liang
%     Date: 21/11/2023
k=zeros(6,6,5);
L=1.5*H;
I=Iw;
A=Aw;
for i=[1 5]
    k(:,:,i)=[E*A/L 0 0 -E*A/L 0 0;
        0 12*E*I/L^3 6*E*I/L^2 0 -12*E*I/L^3 6*E*I/L^2;
        0 6*E*I/L^2 4*E*I/L 0 -6*E*I/L^2 2*E*I/L;
        -E*A/L 0 0 E*A/L 0 0;
        0 -12*E*I/L^3 -6*E*I/L^2 0 12*E*I/L^3 -6*E*I/L^2;
        0 6*E*I/L^2 2*E*I/L 0 -6*E*I/L^2 4*E*I/L];
end
L=3.6*W-2*beta*W;
I=Ib;
A=Ab;
for i=3
    k(:,:,i)=[E*A/L 0 0 -E*A/L 0 0;
        0 12*E*I/L^3 6*E*I/L^2 0 -12*E*I/L^3 6*E*I/L^2;
        0 6*E*I/L^2 4*E*I/L 0 -6*E*I/L^2 2*E*I/L;
        -E*A/L 0 0 E*A/L 0 0;
        0 -12*E*I/L^3 -6*E*I/L^2 0 12*E*I/L^3 -6*E*I/L^2;
        0 6*E*I/L^2 2*E*I/L 0 -6*E*I/L^2 4*E*I/L];
end
L=beta*W;
I=1e10; % 1e10 is much bigger than Iw, Ib, Aw, Ab, so element 2 and 4 can be considered as rigid beam here
A=1e10;
for i=[2 4]
    k(:,:,i)=[E*A/L 0 0 -E*A/L 0 0;
        0 12*E*I/L^3 6*E*I/L^2 0 -12*E*I/L^3 6*E*I/L^2;
        0 6*E*I/L^2 4*E*I/L 0 -6*E*I/L^2 2*E*I/L;
        -E*A/L 0 0 E*A/L 0 0;
        0 -12*E*I/L^3 -6*E*I/L^2 0 12*E*I/L^3 -6*E*I/L^2;
        0 6*E*I/L^2 2*E*I/L 0 -6*E*I/L^2 4*E*I/L];
end
end