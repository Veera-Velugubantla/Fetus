function [A,E,y] = nlmsmiso(x1,x2,x3,d,beta,nord,a0)
[M,N] = size(x1);
if nargin < 7,   a0 = zeros(1,N);   end
Y(1)= a0*x1(1,:).'+a0*x2(1,:).'+a0*x3(1,:).';
E(1) = d(1) - a0*x1(1,:).'-a0*x2(1,:).'-a0*x3(1,:).'; 
D=(x1(1,:)*x1(1,:)' + 0.00003)+(x2(1,:)*x2(1,:)' + 0.00003)+(x3(1,:)*x3(1,:)' + 0.00003);
A(1,:) = a0 + beta/D*E(1)*(conj(x1(1,:))+conj(x2(1,:))+conj(x3(1,:)));
if M>1
for k=2:M-nord+1;
    y(k) = A(k-1,:)*(x1(k,:).'+x2(k,:).'+x3(k,:).');
    E(k) = d(k) - y(k);
    D=(x1(k,:)*x1(k,:)' + 0.00003)+(x1(k,:)*x1(k,:)' + 0.00003)+(x1(k,:)*x1(k,:)' + 0.00003); 
    A(k,:) = A(k-1,:) + beta/D*E(k)*(conj(x1(k,:))+conj(x2(k,:))+conj(x3(k,:)));
end;
end;



