function tfAmp = getAmp(TransferFunc,f)
%Description: the getAmp() function gets the absolute amplitude part of a
%transfer function. 
%Usage of the getAmp() function:
%
% variables:
% TransferFunc: the transfer function.
% f: frequency range with unit 'Hz'.
% tfAmp : the amplitude section of the TransferFunc (absolute value).
%
% for example:
%
% s = tf('s');
% H = 1/(1+s);
% f = logspace(0,2,1000);
% S = getAmp(H,f);
% loglog(f,S);
%
% Data created: 2023/5/23
% Data modified: 
% Author: Ouyang

p = bodeoptions;
p.FreqUnits = 'Hz';  % set x axis unit from 'rad/s' to 'Hz'
p.MagUnits = 'abs';

[n,~] = bode(TransferFunc,2*pi*f);
S = [];
S(1,:) = n(1,1,:);
tfAmp = S;

end

