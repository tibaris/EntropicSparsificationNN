%%
%% SPARTAn is (c) 2022, Illia Horenko. SPARTAn is published and distributed under the Academic Software License v1.0 (ASL). SPARTAn is distributed in the hope
%% that it will be useful for non-commercial academic research, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
%% A PARTICULAR PURPOSE. See the ASL for more details. You should have received a copy of the ASL along with this program; if not, write to horenkoi@usi.ch
%%

function [W]=SPARTA_EvaluateW(X,pi,Lambda,d,T,m,W,eps_C)
%options=optimset('GradObj','on','Algorithm','sqp','MaxIter',20,'Display','off','TolFun',1e-13,'TolCon',1e-13,'TolX',1e-13,...
%    'TolConSQP',1e-13,'TolGradCon',1e-13,'TolPCG',1e-13,'MaxFunEval',20000,'UseParallel',false);
A=-speye(d);
b=sparse(d,1);
%% TIN:
%% X matrix (d,T)
%% pi matrix (m, T)
%% Lambda matrix (m,d+1) -> 1st column intercept
%% Xb matrix (d,T) ---> then scalar product with w gives a scalar
%% In our case m = 1
alpha=0;
bet=0;
Xb=zeros(d,T);
for ind_m=1:m
    for i=1:d
        Xb(i,:)=Lambda(ind_m,i+1)*X(i,:);
    end
    alpha=alpha+Xb*Xb';
    bet=bet+(pi(ind_m,:)-Lambda(ind_m,1))*(Xb)';
end

alpha=alpha/(T*m); %*reg_param
bet=-2*bet/(T*m); %*reg_param
%gam=(1/T)*trace(gamma'*C'*C*gamma);
%(X-C*gamma);alpha=sum(alpha.^2,2)';

%% condition to be probability distribution
Aeq=ones(1,d);
beq=1;
%tic;
%options = optimoptions(@fmincon,...
%    'Algorithm','interior-point',...
%    'MaxIter',20,...
%    'SpecifyObjectiveGradient',true, ...
%    'Display','off','TolFun',1e-20,'TolCon',1e-14,'TolPCG',1e-14,'TolX',...
%    1e-14,'TolConSQP',1e-14,'TolGradCon',1e-14,'TolPCG',1e-14,'OptimalityTolerance',1e-20,'StepTolerance',1e-20);
options = optimoptions(@fmincon,...
    'Algorithm','interior-point',...
    'MaxIter',200,...
    'SpecifyObjectiveGradient',true, ...
    'HessianFcn',@(x,lambda)hessinterior(x,lambda,alpha,eps_C),'HessPattern',0,...
    'Display','off','TolFun',1e-14,'TolCon',1e-14,'TolPCG',1e-14,'TolX',...
    1e-14,'TolConSQP',1e-14,'TolGradCon',1e-14,'TolPCG',1e-14,'OptimalityTolerance',1e-10,'StepTolerance',1e-10, 'UseParallel', true);

options.ConstraintTolerance = 1e-12;
% added
options = optimoptions(options,'UseParallel',true);
fff0=LogLik_SPACL_W(W,d,alpha,bet,eps_C);
W_old=W;
%original input
%[W,fff,flag,output] =  fmincon(@(x)LogLik_SPACL_W...
%    (x,d,alpha,bet,eps_C)...
%    ,W,(A),(b),Aeq,beq,[],[],[],options);

%modification
lb = zeros(1,d);
ub = ones(1,d);
[W,fff,flag,output] =  fmincon(@(x)LogLik_SPACL_W...
    (x,d,alpha,bet,eps_C)...
    ,W,[],[],Aeq,beq,lb,ub,[],options);

%% does it allow for negative W?
%% it does!
%% it is not bounded by 1 (after using absolute value)
%% think about it....

% W=abs(W);
fff=LogLik_SPACL_W(W,d,alpha,bet,eps_C);
if fff0<fff
    W=W_old;
end
%toc
%fun=LogLik_SPACL_Lambda(xxx0,gamma,pi,m,K)-LogLik_SPACL_Lambda(xxx,gamma,pi,m,K);[fun]=LogLik_SPACL_gamma(xxx0,X(:,t),pi(:,t),Lambda,eps1,eps2,C,CTC)-fff

end

function [fun,grad]=LogLik_SPACL_W(W,d,alpha,beta,eps_C)
fun=beta*W'+W*alpha*W'+eps_C*sum(W.*(log(max(W,1e-12))));
grad=real(beta+2*(alpha*W')'+eps_C.*(log(max(W,1e-12))+ones(1,d)));
end

function H = hessinterior(W,lambda,alpha,eps_C)
%HMFLEQ1 Hessian-matrix product function for BROWNVV objective.
%   W = hmfleq1(Hinfo,Y,V) computes W = (Hinfo-V*V')*Y
%   where Hinfo is a sparse matrix computed by BROWNVV 
%   and V is a 2 column matrix.
H=2*alpha+diag(eps_C./max(W,1e-12));


end


