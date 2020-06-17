function [A,E,Y] = lmssource1(x1,x2,x3,d,mu,nord,a0)

[M,N,L] = size(x1);

if nargin < 7  
    a0 = zeros(1,N);  
end

Y(1)=a0*x1(1,:)'+a0*x2(1,:)'+a0*x3(1,:)';
E(1)=d(1)-Y(1); %error
A(1,:) = a0 + mu*E(1)*(conj(x1(1,:)+conj(x2(1,:))+conj(x3(1,:))));

for k=2:M-nord+1;
       
       Y(k)=A(k-1,:)*x1(k,:)'+A(k-1,:)*x2(k,:)'+A(k-1,:)*x3(k,:)';
        E(k) = d(k) - Y(k);
        A(k,:)=A(k-1,:)+mu*E(k)*(conj(x1(k,:)+conj(x2(k,:))+conj(x3(k,:))));
     
end
