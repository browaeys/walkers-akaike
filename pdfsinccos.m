function res = pdfsinccos(x, a, b)
% PDFSINCCOS  Computes the pdf of a sinc cos distribution
%   C = PDFSINCCOS(X, A, B) 
%   where A is the parameter and X the value of the variable in degrees
%
%   C = abs( sin(a*pi*sin(x*pi/180)) ./ (a*pi*sin(x*pi/180))
%       .* cos(b*pi*sin(x*pi/180)) )
%
%   See also PDFSINC
    
    nsinccos = @(y,a,b) abs(  sinc(a*sin(y*pi/180)) .* cos(b*pi*sin(y*pi/180))  );
    res = nsinccos(x, a, b)/integral(@(y)nsinccos(y,a,b),-90,90);
end
