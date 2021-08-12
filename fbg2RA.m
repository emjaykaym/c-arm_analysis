function fbg_saveall = fbg2RA(inputdir)
% input directory of all the fbg files  
% output a cell of arrays of data
% last update 08/12/2021 Min Jung Kim

S = dir(fullfile(inputdir,'*.TXT'));
fbg_saveall = cell(1,numel(S)); % initializing

for k = 1:numel(S)
    fbg_file = fullfile(inputdir,S(k).name);
    fbg_data = readmatrix(fbg_file, 'Delimiter', {',', ':'});
    fbg_saveall{k} = fbg_data(:,2:10); % the first column is irrelevant
end
end


