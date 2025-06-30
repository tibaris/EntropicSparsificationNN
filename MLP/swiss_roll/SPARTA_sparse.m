function [W,Lambda,L] = SPARTA_sparse(X,Y,Lambda,T,d,m, reg_param, eps_C,W)
%initialize W
%W = rand(1,d); 
%W = W/sum(W);
W = ones(1,d)/d;
%if rand_init
%    W = rand(1,d);
%    W = W/sum(W);
%end

%first step
L = SPARTA_L_v2(X,Y,Lambda,T,d,m, reg_param, eps_C,W);
Lambda = SPARTA_EvaluateLambdaRegularize(X,W,Y,m,d,T,reg_param);
%L = [L, SPARTA_L_v2(X,Y,Lambda,T,d,m, reg_param, eps_C,W)];
W = SPARTA_EvaluateW(X,Y,Lambda,d,T,m,W,eps_C);
%W = W/sum(W);
L = [L, SPARTA_L_v2(X,Y,Lambda,T,d,m, reg_param, eps_C,W)];
%tolerance
tol = 0.001;
%while loop until convergences
const = 2*tol;
%for i = 1:20
i = 0;
while abs((L(length(L)) - L(length(L)-1))) + const > tol
    %Lambda = Lambda + 0.05*rand(m, d+1);
    i = i+1;
    Lambda = SPARTA_EvaluateLambdaRegularize(X,W,Y,m,d,T,reg_param);
    W = SPARTA_EvaluateW(X,Y,Lambda,d,T,m,W,eps_C);
    %W = W/sum(W);
    %Lambda = SPARTA_EvaluateLambdaRegularize(X,W,Y,m,d,T,reg_param);
    L = [L, SPARTA_L_v2(X,Y,Lambda,T,d,m, reg_param, eps_C,W)];
    const = 0;
    if i == 50 
        break
    end
end 

end