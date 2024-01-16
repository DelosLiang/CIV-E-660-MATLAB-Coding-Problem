clc
clear all
close all
%% To generate how the displacement at A will decrease as a function of β when β takes different values.
beta=0.05:0.01:1.75;
U_x=zeros(1,length(beta));
U_y=zeros(1,length(beta));
U_len=zeros(1,length(beta));
for i=1:length(beta)
    U=ugenerator(beta(i));
    U_x(i)=U(1);
    U_y(i)=U(2);
    U_len(i)=sqrt(U(1)^2+U(2)^2);
end
figure
plot(beta,U_x,'b-','LineWidth',1.5)
grid on
xlim([0 1.8])
box on
xlabel('Value of \beta','FontSize',16)
ylabel('Displacement along x-axis at A (in)','FontSize',16)
set(gca,'FontSize',16);
figure
plot(beta,U_y,'b-','LineWidth',1.5)
grid on
xlim([0 1.8])
box on
xlabel('Value of \beta','FontSize',16)
ylabel('Displacement along y-axis at A (in)','FontSize',16)
set(gca,'FontSize',16);
figure
plot(beta,U_len,'b-','LineWidth',1.5)
grid on
xlim([0 1.8])
box on
xlabel('Value of \beta','FontSize',16)
ylabel('The length of displacement at A (in)','FontSize',16)
set(gca,'FontSize',16);
