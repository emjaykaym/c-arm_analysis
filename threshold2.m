function [a, newMat, value] = threshold2(Y, info,minThreshold,maxThreshold)
%function [newMat] = slicerThreshold(Y, info,nargin)
% function which finds and plots datapoints between minThreshold and
% maxThreshold based on Y
% FiducialsList, plots datapoints from RAS coordinate system
% minThreshold = min percentage of the max willing to be thresholded
% maxThreshold = max percentage willing to be thresholded
% subparts = if you want to divide thresholding into number of parts
% inputdir = directory of dicom images
% FiducialsList = list of trajectory exported from slicer
% graphLim = turn limits on or off on graph, 1 = on
% output = the indices of thresholded datapoints
if minThreshold < 1
    maxM = max(Y,[],'all');
    maxthres = maxThreshold*maxM;
    minthres = minThreshold*maxM;
    between = maxthres-minthres;
    [ind,jnd,knd]=findND(Y>minthres & Y<=minthres+(between));
    value = Y(Y>minthres & Y<=minthres+(between));
else
    minthres = minThreshold;
    [ind,jnd,knd]=findND(Y>minthres);
    value = Y(Y>minthres);
    
end
% the origin is at 0,0,0
delx = info.PixelSpacing(1);
dely = info.PixelSpacing(2);
delz = info.SliceThickness;

in = (ind-1)*delx;
jn = (jnd-1)*dely;
kn = (knd-1)*delz;

% figure;
value = value /max(value);
a = 0;
% a = scatter3(in,jn,kn,30,'k.');
%hold on
%xlabel('Right (mm) y');
%ylabel('Anterior (mm) x');
%zlabel('Superior (mm) z');
%title("Threshold " + minThreshold*100 + "th to " + maxThreshold*100 + "th percentile")

%axis equal;
% hold off;
newMat = [in,jn,kn];
end
