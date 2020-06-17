function [W,E,y] = llmsh(X,d,mu,gammax,nord,a0)
X=convm(X,nord);
[M,N] = size(X);
if nargin < 6,   a0 = zeros(1,N);   end
a0   = a0(:).';
y= zeros(1,M);
E=zeros(1,M);
W= zeros(size(X));
Y(1)= a0*X(1,:).';
E(1) = d(1) - a0*X(1,:).'; 
W(1,:) = (1-mu*gammax)*a0 + mu*E(1)*conj(X(1,:));
if M>1
for k=2:M-nord+1;
    y(k) = W(k-1,:)*X(k,:).';
    E(k) = d(k) - y(k);
    W(k,:) = (1-mu*gammax)*W(k-1,:) + mu*E(k)*conj(X(k,:));
end;
end;