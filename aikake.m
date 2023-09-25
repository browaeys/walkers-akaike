
tic

%% Initiate the MC procedure
NMC = 1000 ;
mcarlo = zeros(NMC, 5) ;

%% Repeat the procedure
for k=1:NMC 

    %create dataset from the Couder histogram    
    datasynth
    
    % -2*log-likelihood of the sinc pdf of the data 
    likesinc = @(a) sum(-2*log(pdfsinc(data, a))) ;

    % -2*log-likelihood of the sinccos pdf of the data 
    likesinccos = @(c) sum(-2*log(pdfsinccos(data, c(1), c(2)))) ;
    
    %% plot of -2*log-likelihood of the sinc pdf as a function of the parameter
    % N=500 ;
    % xx = linspace(0.01, 4, N) ; yy=zeros(1,N) ;
    % for i=1:N
    %     yy(i) = likesinc(xx(i)) ;
    % end
    % figure 
    % plot(xx, yy)


    %% plot of -2*log-likelihood of the sinccos pdf as a function of the
    % two parameters
    % Nx=100 ; Ny=100;
    % x = linspace(0.6, 0.9, Nx) ; y=linspace(1.3, 1.7, Ny) ; z=zeros(Nx,Ny) ;
    % for i=1:Nx
    %     for j=1:Ny
    %         z(i,j) = likesinccos([x(i),y(j)]) ;
    %     end
    % end
    % figure
    % contour(x, y, z', 'ShowText','on')
    % figure
    % surf(x, y, z')

    %% search for the global minimum of the sinccos negative likelihood
    % setting of a 20*20 grid
    Nx=20 ; Ny=20 ;
    x = linspace(0.5, 1.2, Nx); y=linspace(1, 2, Ny); res = zeros(Nx*Ny, 3);
    % loop the starting point of the locas minimu search on the grid
    for i=0:Nx-1
        for j=0:Ny-1
            [xmin, fval] = fminsearch(likesinccos,[x(i+1),y(j+1)]) ;
            res(i*Ny+j+1, :) = [xmin fval] ;
        end
    end
    % calculate the global minimum and its location
    [lminsc, pos] = min(res(:,3)) ;
    xminsc = res(pos,1:2) ;

    %% search for the minimum of the sinc negative likelihood
    [xmins, lmins] = fminsearch(likesinc,0.3) ;

    %% store the result
    mcarlo(k, :) = [lmins, lminsc, xmins, xminsc(1), xminsc(2)] ;
    
end

AICCs = mcarlo(:, 1) + 2 + 4/73 ;
AICCsc = mcarlo(:, 2) + 4 + 12/73 ;
dAIC = AICCs- AICCsc ;


toc

% figure
% xxx = linspace(-90, 90, 500) ;
% H=histogram([data,-data],-90:5:90) ;
% hold on
% plot(xxx, pdfsinccos(xxx, asc(1), asc(2))*75*5*2,'r', 'LineWidth', 2)
% plot(xxx, pdfsinccos(xxx, asc2(1), asc2(2))*75*5*2,'b', 'LineWidth', 2)
% plot(xxx, pdfsinc(xxx, as)*75*5*2, 'g', 'LineWidth', 2)


% AICCsinc = fval + 2 + 4/73 
% AICCsinccos = lmin + 4 + 12/73 
% deltaAIC = AICCsinc - AICCsinccos

%[h,pValue,stat] = lratiotest(-fvalc/2,-fval/2,1)

lmins = mcarlo(:, 1) ;
lminsc = mcarlo(:, 2) ;
xmins = mcarlo(:, 3) ;
xminsc1 = mcarlo(:, 4) ;
xminsc2 = mcarlo(:, 5) ;
toto = lminsc((xminsc2>1.55)&(xminsc2<1.65)) ;
