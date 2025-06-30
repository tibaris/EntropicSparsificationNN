%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute the value of the functional L in SPARTA
%%
%%
%% SPARTAn is (c) 2022, Illia Horenko. SPARTAn is published and distributed under the Academic Software License v1.0 (ASL). SPARTAn is distributed in the hope
%% that it will be useful for non-commercial academic research, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
%% A PARTICULAR PURPOSE. See the ASL for more details. You should have received a copy of the ASL along with this program; if not, write to horenkoi@usi.ch
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 



function [Le, LS, Lr, L] = SPARTA_L_components(X,pi,Lambda,T,d,m, reg_param, eps_C,W);
     
    regr_dist=0;
    %disc_dist=0;
    %for k=1:K
      %idx{k}=find(gamma(k,:)==1);
      %disc_dist=disc_dist+norm(bsxfun(@times,sqrt(W'),bsxfun(@minus,X(:,idx{k}),C(:,k))),'fro')^2;
      %disp(size(W))
      %disp(size(X))
      for j=1:m
            regr_dist=regr_dist+sum((pi(j,:)-Lambda(j,1)-Lambda(j,2:(d+1))*bsxfun(@times,W',X)).^2);             
            %regr_dist=regr_dist+sum((pi(j,:)-Lambda(j,1)-W.*Lambda(j,2:(d+1))*X)).^2);             
      end
    %end

	% Updating the main functional 
	%L = eps_C * sum(W.*log(max(W,1e-12))) + reg_param*sum(sum(sum(Lambda.^2))); %+ ...
    %L = 1/(T*m) * regr_dist;%+reg_param*sum(sum(sum(Lambda.^2))); %/(d*m)
    L = reg_param*sum(sum(sum(Lambda.^2)))/(d*m) + eps_C * sum(W.*log(max(W,1e-12)))+1/(T*m) * regr_dist;
    %+reg_param*sum(sum(sum(Lambda.^2))); %+ reg_param*sum(sum(sum(Lambda.^2)))+ ...
        %1/(T*m) * regr_dist;%+reg_param*sum(sum(sum(Lambda.^2))); %/(d*m)
    Lr = sum(sum(sum(Lambda.^2)))/(d*m);
    LS = 1/(T*m) * regr_dist;
    Le = sum(W.*log(max(W,1e-12)))+1/(T*m);
end


