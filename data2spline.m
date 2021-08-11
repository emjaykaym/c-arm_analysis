function onepos = data2spline(newMRotated)
x = newMRotated(1,:);
y = newMRotated(2,:);
z = newMRotated(3,:);

% splines
s2x = csaps(z,x,1.3E-7); % 9.9E-7);
s2y = csaps(z,y,2.7E-6); % 8.9E-5);

zq = min(z):.05:max(z);
xp = ppval(s2x,zq);
yp = ppval(s2y,zq);
onepos = [xp;yp;zq]; % c-arm
end