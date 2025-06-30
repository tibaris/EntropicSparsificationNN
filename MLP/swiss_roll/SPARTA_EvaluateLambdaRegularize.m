%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Computation of Lambda in SPARTA
%%
%%
%% SPARTAn is (c) 2022, Illia Horenko. SPARTAn is published and distributed under the Academic Software License v1.0 (ASL). SPARTAn is distributed in the hope
%% that it will be useful for non-commercial academic research, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
%% A PARTICULAR PURPOSE. See the ASL for more details. You should have received a copy of the ASL along with this program; if not, write to horenkoi@usi.ch
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 


function [Lambda]=SPARTA_EvaluateLambdaRegularize(X,W,pi,m,N,T,eps_L2);

Lambda=zeros(m,N+1);
eps=eps_L2*T/N;
%for k=1:K
      %idx{k}=find(gamma(k,:)==1);
      XW=[ones(1,T); bsxfun(@times,W',X)];
      %Lambda(1,:)=((XW*XW'+eps*eye(N+1))\(XW*pi(1,:)'))';
      for i = 1:m
        Lambda(i,:)=((XW*XW'+eps*eye(N+1))\(XW*pi(i,:)'))';
      end
%end
%beta=((Xw*Xw'+eps_l2*T*eye(m))\(Xw*pi_train'))';
