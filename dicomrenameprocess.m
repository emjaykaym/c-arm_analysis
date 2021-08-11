function dicomrenameprocess(inputdir)
% function that iterates through all the .ima files in a certain folder
% specified by inputdir, and converts them into a format that matlab can
% read then puts all the new dicom files into separate folders by each 
% set of 256 ima files for compatibility with rest of the code
% not the best code but that's ok
% 08/11/21 Min Jung Kim
S = dir(fullfile(inputdir,'*.IMA'));
for k = 1:numel(S)
    % fnm = fullfile(inputdir,S(k).name);
    % rename the files
    dicomrename(inputdir,S(k).name,'rename');
end
% move all files to individual folders
allFileNames = {S.name};
temp = 0;
for k = 1 : length(allFileNames)
    thisName = allFileNames{k};
    [~, baseFileNameNoExt, ~] = fileparts(thisName);
    if ~contains(baseFileNameNoExt, '.')
        continue; % skip names with no dot in them
    end
    fprintf('Processing %s.\n', baseFileNameNoExt);
    nameParts = strsplit(baseFileNameNoExt, '.');
    if nameParts{end-1} ~= temp
        temp = nameParts{end-1};
        mkdir(inputdir,temp);
    end
    if ispc
        movefile(strcat(inputdir,'\',thisName),strcat(inputdir,'\',temp));
    else
        movefile(strcat(inputdir,'/',thisName),strcat(inputdir,'/',temp));
    end
end

end