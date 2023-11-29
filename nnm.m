function [] = NNM(figureNo)
%   NNM adds the new low-noise model(NLNM) and the new high-noise model(NHNM)
%   to the plot.
%   ---------------------
%   Reference : Peterson J. Observations and modeling of seismic background
%   noise[M]. Reston, VA, USA: US Geological Survey, 1993.
%   --------------------- 
%   INPUT: figureNo is the figure number you want to plot with. If not assigned, NNM will
%   plot to the current active figure.
%
%   OUTPUT: /
%   ---------------------
%   Example:
%   ---------------------
%   figure(234)
%   loglog(freq, Pxx1)     % your PSD plot
%   nnm(234)               % add NLNM and NHNM to your plot
%   ---------------------
%   Created by Ouyang, 2023/10/19
if(nargin == 1)
    figure(figureNo)
    hold on
elseif(nargin == 0)
    hold on
end
% NLNM
LP = [0.1 0.17 0.40 0.80 1.24 2.4 4.3 5 6 10 12 15 21.9 31.6 45 70 101 154 328 600 10000 100000];
LA = [-162.36 -166.7 -170 -166.4 -168.6 -159.98 -141.1 -71.36 -97.26 -132.18 -205.27 -37.65 -114.37 -160.58 -187.5 -216.47 -185 -168.34 -217.43 -258.28 -346.88 -346.88];
LB = [5.64 0 -8.3 28.9 52.48 29.81 0 -99.77 -66.49 -31.57 36.16 -104.33 -47.1 -16.28 0 15.7 0 -7.61 11.9 26.6 48.75 48.75];
LF = 1./LP;
NLNM_accdB = LA + LB.*log10(LP);   % dB refered to 1 (m/sec^2)^2/Hz
% semilogx(LF,NLNM_acc,'r-^')
NLNM_acc = sqrt(10.^(NLNM_accdB./10))/9.8;   % g/Hz^-1/2
loglog(LF,NLNM_acc,'r-^','DisplayName','NLNM')
hold on

% NHNM
HP = [0.1 0.22 0.32 0.8 3.8 4.6 6.3 7.9 15.4 20 354 100000];
HA = [-108.73 -150.34 -122.31 -116.85 -108.48 -74.66 0.66 -93.37 73.54 -151.52 -206.66 -206.66];
HB = [-17.23 -80.5 -23.87 32.51 18.08 -32.95 -127.18 -22.42 -162.98 10.01 31.63 31.63];
HF = 1./HP;
NHNM_accdB = HA + HB.*log10(HP);   % dB refered to 1 (m/sec^2)^2/Hz
% semilogx(HF,NHNM_acc,'b-^')
NHNM_acc = sqrt(10.^(NHNM_accdB./10))/9.8;   % g/Hz^-1/2
loglog(HF,NHNM_acc,'b-^','DisplayName','NHNM')
hold off

end

