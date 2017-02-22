%% Problem 1.2 b)
H=[1 0 0; 0 1 0; 0 0 0];
f=zeros(3,1);
A=[-2 -2 -1;
    -4 -4 -1;
    -4 0 -1 ;
    0 0 1;
    2 0 1;
    0 2 1];
b=-ones(6,1);

w=quadprog(H,f,A,b);
%% Problem 1.2 d)
H=[8 16 8 0 -4 -4;
    16 32 16 0 -8 -8;
    8 16 16 0 -8 0;
    0 0 0 0 0 0;
    -4 -8 -8 0 4 0;
    -4 -8 0 0 0 4];
f=-ones(6,1);
A=zeros(6);
b=zeros(6,1);
Aeq=[1 1 1 -1 -1 -1];
beq=0;
lb=zeros(6,1);


alpha=quadprog(H,f,A,b,Aeq,beq,lb);