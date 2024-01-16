function f_global=f_global_cal(f_local)
% f_local_cal(disp_local,k_local) - This function determines element end
% forces in the global coordinate system.
%     
%     Input:
%     f_local - Element end forces in the local coordinate system.
%     
%     Output:
%     f_global - Element end forces in the global coordinate system.
%     
%     Author: Haoran Liang
%     Date: 04/10/2023
f_global=zeros(9,4);
for i=4:7
    for j=1:4
        f_int=trans(0)'*f_local(i,:)';
        f_global(i,j)=f_int(j);
    end
end
for i=1:3
    for j=1:4
        f_int=trans(pi/2)'*f_local(i,:)';
        f_global(i,j)=f_int(j);
    end
end
f_int=trans(3*pi/4)'*f_local(8,:)';
for j=1:4
    f_global(8,j)=f_int(j);
end
f_int=trans(pi/4)'*f_local(9,:)';
for j=1:4
    f_global(9,j)=f_int(j);
end
end