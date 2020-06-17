function [W,E,y] = llmshmiso(x1,x2,x3,d,mu,gammax,nord,a0)

[M,N] = size(x1);
if nargin < 8
    a0 = zeros(1,N);
end

y(1)= a0*x1(1,:).'+a0*x3(1,:).'+a0*x2(1,:).';
E(1) = d(1) - y(1); 
W(1,:) = (1-mu*gammax)*a0 + mu*E(1)*(conj(x1(1,:))+conj(x2(1,:))+conj(x3(1,:)));
if M>1
for k=2:M-nord+1;
    y(k) = W(k-1,:)*(x1(k,:).'+x2(k,:).'+x3(k,:).');
    E(k) = d(k) - y(k);
    W(k,:) = (1-mu*gammax)*W(k-1,:) + mu*E(k)*(conj(x1(k,:))+conj(x2(k,:))+conj(x3(k,:)));
end;
end;