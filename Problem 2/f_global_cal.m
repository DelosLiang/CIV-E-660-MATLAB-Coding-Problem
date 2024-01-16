function f_global=f_global_cal(f_local)
% f_local_cal(disp_local,k_local) - This function determines element end forces in the global coordinate system.
%     
%     Input:
%     f_local - Element end forces in the local coordinate system.
%     
%     Output:
%     f_global - Element end forces in the global coordinate system.
%     
%     Author: Haoran Liang
%     Date: 27/11/2023
f_global=zeros(5,6);
for i=2:4
    for j=1:6
        f_int=trans(0)'*f_local(i,:)';
        f_global(i,j)=f_int(j);
    end
end
for i=[1]
    for j=1:6
        f_int=trans(pi/2)'*f_local(i,:)';
        f_global(i,j)=f_int(j);
    end
end
for i=[5]
    for j=1:6
        f_int=trans(3*pi/2)'*f_local(i,:)';
        f_global(i,j)=f_int(j);
    end
end
end