function res = randsc(a, b, n)
% RANDSC  returns an random vector of n i.i.d following a sinccos
% distribution
%   C = RANDSC(A, B, N) 
%   where N is the number of rows,
%   A and B the parameters of the sinccos distribution : 
%
%   K * abs( sin(a*pi*sin(x*pi/180)) ./ (a*pi*sin(x*pi/180))
%       .* cos(b*pi*sin(x*pi/180)) )
%
%   See also PDFSINCCOS

%% Simulateur de nombre al�atoires
res = zeros(1, n) ;
i=1 ;
while(i<=n)
    X=pi*(-0.5+rand(1)); 
    % tirage al�atoire d'un angle en degr�s
    Y=rand(1); 
    % deuxi�me tirage al�atoire (n�cessaire pour l'algorithme de rejet)
    fX=abs(sin(pi*a*sin(X))*cos(pi*b*sin(X))/(pi*a*sin(X))); % f(alpha)
    while (fX<Y) 
    % condition de rejet
        X=pi*(-0.5+rand(1));
        Y=rand(1);
        fX=abs(sin(pi*a*sin(X))*cos(pi*b*sin(X))/(pi*a*sin(X)));
    end
    res(i)=X*180/pi; 
    % quand la valeur n'est pas rejet�e on la stocke en degr�s dans a
    i=i+1;
    % et on incr�mente le compteur
end
