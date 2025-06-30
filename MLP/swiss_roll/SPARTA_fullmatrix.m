
%% number of training samples
T = 3000;
%% feature dimension
d = 784;
%% output dimension
m = 500;

flag = 1;

tic
if flag == 1
    X = readmatrix("layer1-Xtrain-MLP-scaled.csv");
    X = transpose(X);
    X = X(2:(d+1),2:(T+1));

    Y = readmatrix("layer1-Ytrain-MLP-scaled.csv");
    Y = transpose(Y);
    Y = Y(2:(m+1),2:(T+1));
end
toc



%% initialize epsilon(s)
eps_C = -0.0005;
reg_param = 0.0005; 

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
plot(estA(1,:))


[Le, LS, Lr, Ltotal] = SPARTA_L_components(X,Y,Lambda,T,d,m,  reg_param, eps_C,W);

Yp = estA*X + Lambda(:,1);


%for i = 201:300
    %Y1 = Y(i,2:40001);
    %Y1 = Y(i,2:5001);
    %t1 = quantile(Y1,0.05);
    %t2 = quantile(Y1,0.95);
    %ind = Y1>t1 & Y1<t2;
    %X1 = X(:,ind);
    %Y1 = Y1(1,ind);
    %T = sum(ind);
    %W = ones(1,d)/d;
    %Lambda = rand(m, d+1);
    %disp(i)
    %tic
    %[W_mat(i,:),Lambda_mat(i,:),L] = SPARTA_sparse(X1,Y1,Lambda,T,d,m, reg_param, eps_C,W);
    %toc
    %[W2,Lambda2,L02] = SPARTA_sparseW(X,Y,Lambda,T,d,m, reg_param, eps_C,W, true)
%end


save('results/W_fullp4_layer1', 'W');
save('results/Lambda_fullp4_layer1', 'Lambda');
save('results/estAp4_layer1', 'estA');

sum(W>10^-4)
