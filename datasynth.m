
%% Synthesis of 75 random values compatible with the published histogram

% frequencies on open positive bins
eff_ouverts_pos=[12,7,4,2,4,7,7,6,5,6,4,2,3,0,1,2,0,1];

% left edges of positive bins
edges=0:5:85; 

% seed the random number generator
%rng('shuffle')
%rng('default') 

% create the data

data = [];
for i=1:18
    data = [data, randi([1,49],1,eff_ouverts_pos(i))/10 + edges(i)];
end

% add two positive values deduced from histogram asymetries
data = [data, 5, 15] ;

% randomize sign of data
data = data .* (randi([0,1],1,75)*2-1) ;

% clear unneeded variables
clear i
clear eff_ouverts_pos
