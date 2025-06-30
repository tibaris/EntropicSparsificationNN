%% number of training samples
%T = 40000;
T = 3000;
%% feature dimension
d = 300;
%% output dimension
m = 10;

flag = 1;

tic
if flag == 1
    X = readmatrix("layer3-Xtrain-MLP-scaled.csv");
    X = transpose(X);
    X = X(2:(d+1),2:(T+1));

    Y = readmatrix("layer3-Ytrain-MLP-scaled.csv");
    Y = transpose(Y);
    Y = Y(2:(m+1),2:(T+1));
end
toc


%% initialize epsilon(s)
eps_C = 0;
reg_param = 0.001; 

%p1 0.1, 0.1
%p2 0.01, 0.01
%p3 0.001, 0.001
%p4 0.0001, 0.0001
%p5 0.00001, 0.00001

%% initialize output variables
W = ones(1,d)/d;
%rng(100);
%W = rand(1,d);
%W = W/sum(W);
Lambda = rand(m, d+1);
Lambda_mat = rand(m, d+1);


tic
[W,Lambda,L] = SPARTA_sparse(X,Y,Lambda_mat,T,d,m, reg_param, eps_C,W);
toc

estA = bsxfun(@times,W, Lambda(:,2:size(Lambda,2)));

figure(1)
plot(W)
%plot(estA(1,:))


[Le, LS, Lr, Ltotal] = SPARTA_L_components(X,Y,Lambda,T,d,m,  reg_param, eps_C,W);

Yp = estA*X + Lambda(:,1);


%save('results/W_fullp4_layer3', 'W');
%save('results/Lambda_fullp4_layer3', 'Lambda');
%save('results/estAp4_layer3', 'estA');



sum(W>10^-4)
