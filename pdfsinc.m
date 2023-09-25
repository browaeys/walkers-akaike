function res = pdfsinc(x, a)
% PDFSINC  Computes the pdf of a sinc distribution
%   C = PDFSINC(X, A) 
%   where A is the parameter and X the value of the variable in degrees
%
%   C = abs(sin(a*pi*sin(x*pi/180))./(a*pi*sin(x*pi/180)))
%
%   See also PDFSINCCOS

    nsinc=@(y,a) abs(  sinc(a*sin(y*pi/180)) );
    res = nsinc(x, a)/integral(@(y)nsinc(y,a),-90,90);
end