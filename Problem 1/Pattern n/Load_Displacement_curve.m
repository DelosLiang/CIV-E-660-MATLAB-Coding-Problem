clear all;
clc;
figure
x=[2 4 6 8 10];
y1=[-1.472e-05 -7.180e-05 -2.359e-04 -6.148e-04 -1.359e-03];
y2=[-8.251e-06 -5.671e-05 -2.122e-04 -5.824e-04 -1.318e-03];
plot(x,y1,'b-o','LineWidth',1.5)
hold on
plot(x,y2,'r->','LineWidth',1.5)
grid on
xlim([2 10])
box on
xlabel('Number of spans','FontSize',16)
ylabel('Displacement along y-axis (m)','FontSize',16)
set(gca,'FontSize',16);
legend('Pattern A','Pattern B','FontSize',16,'Location','northeast');