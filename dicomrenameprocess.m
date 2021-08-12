function dicomrenameprocess(inputdir)
% function that iterates through all the .ima files in a certain folder
% specified by inputdir, and converts them into a format that matlab can
% read then puts all the new dicom files into separate folders by each 
% set of 256 ima files for compatibility with rest of the code
% not the best code but that's ok
% last updated 08/12/21 Min Jung Kim

% future updates: 
% 1) only sort the even number files into folders
% 2) not sure why there is a folder called 531250 being made
% 3) there is a better way to code this instead of turning the warning off then back on
% (ie: check if directory already exists)

S = dir(fullfile(inputdir,'*.IMA'));
for k = 1:numel(S)
    % fnm = fullfile(inputdir,S(k).name);
    % rename the files
    dicomrename(inputdir,S(k).name,'rename');
end
% move all files to individual folders

%%
fprintf('Wait a second and press any key to continue. \n');
pause; % an error occurs otherwise
allFileNames = {S.name};
warning('off','MATLAB:MKDIR:DirectoryExists') 
for k = 1 : length(allFileNames)
    thisName = allFileNames{k};
    [~, baseFileNameNoExt, ~] = fileparts(thisName);
    if ~contains(baseFileNameNoExt, '.')
        continue; % skip names with no dot in them
    end
    fprintf('Processing %s.\n', baseFileNameNoExt);
    nameParts = strsplit(baseFileNameNoExt, '.');
    temp = nameParts{end-1};
    mkdir(inputdir,temp); 
    % if the 3rd last section is all numbers, move the file to directory
    if ~any(isstrprop(nameParts{end-2},'alpha')) 
        if ispc
            movefile(strcat(inputdir,'\',thisName),strcat(inputdir,'\',temp));
        else
            movefile(strcat(inputdir,'/',thisName),strcat(inputdir,'/',temp));
        end
    end
end
warning('on','MATLAB:MKDIR:DirectoryExists')

end