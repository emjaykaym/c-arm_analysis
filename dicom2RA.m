function [Y,info] = dicom2RA(inputdir)
% returns a 3D matrix based on set of dicom images, whose directory is
% specified by inputdir. make sure there are no other .ima files in the
% directory (i.e. only the 256 ima files pertaining to each set should be
% in the folder.
% may be helpful to add ridge filter to this

S = dir(fullfile(inputdir,'*.IMA'));
Y = zeros(256,256,256);
se = strel('disk',3);
for k = 1:numel(S)
    fnm = fullfile(inputdir,S(k).name);
    info = dicominfo(fnm);
    Y(:,:,k) = dicomread(info);
    %bothat filter: increase contrast, smooth out background variations
    Y(:,:,k) = imsubtract(imadd(Y(:,:,k),imtophat(Y(:,:,k),se)),imbothat(Y(:,:,k),se));
    % gaussian filter: remove noise
    % Y(:,:,k)= imgaussfilt(Y(:,:,k),1);
    %[~,Yr(:,:,k)] = ridgefilt(Y(:,:,k),2,1,.3);
end
end