%% Plot of data in 2.1
load dataset2.mat
x1=x(y == 1,:);
x2=x(y == -1,:);
plot3(x1(:,1),x1(:,2),x1(:,3),'r*','DisplayName','$y=1$')
hold on
plot3(x2(:,1),x2(:,2),x2(:,3),'bo','DisplayName','$y=-1$')
set(gca,'fontsize', 15);
xlabel('$x_1$','Interpreter', 'LaTex')
ylabel('$x_2$','Interpreter', 'LaTex')
zlabel('$x_3$','Interpreter', 'LaTex')
h=legend('show');
set(h,'Interpreter','latex')