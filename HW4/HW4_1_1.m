%% Problem 1.1 
x1=[2 2; 4 4; 4 0]; % Class +1
x2=[0 0; 2 0; 0 2]; % Class -1
line=linspace(-1,5);

scatter(x1(:,1),x1(:,2),'b','DisplayName','$y=1$')
hold on
scatter(x2(:,1),x2(:,2),'r','DisplayName','$y=-1$')
plot(line,3-line,'k','DisplayName','Decision Boundary')
axis([-1 5 -1 5])
title('Problem 1.1','Interpreter','LaTex')
xlabel('$x_{1}$','Interpreter', 'LaTex')
ylabel('$x_{2}$','Interpreter', 'LaTex')
h=legend('show');
set(h,'Interpreter','latex')