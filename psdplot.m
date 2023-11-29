function [SpectraData,FrequencyInf,nfft] = psdplot(Data,SampleRate,Smoothing,Legend)
% SPLOT: Plot power spectra density using Pwelch function.
%   -------------------Usage------------------------
%   psdplot(Data,SampleRate): plot the power spectra density.
%
%   psdplot(Data,SampleRate,Smoothing): plot the power spectra density with
%   smoothing(only if the third input is Numeric).
%
%   psdplot(Data,SampleRate,Legend): plot the power spectra density with
%   legend(only if the third input is Char).
%
%   psdplot(Data,SampleRate,Smoothing,Legend):plot the power spectra density with
%   smoothing and legend.
%
%   Getting the original spectra and frequency data by using:
%   [SpectraData,FrequencyInf,nfft] = psdplot(Data,SampleRate,...);
%
% ---------------INPUTS AND OUTPUTS----------------
% SpectraData: output spectra data (Amplitude^2/Hz)
% FrequencyInf: output frequency data (Hz)
% Data: data to plot PSD
% SampleRate: Sample rate(Unit: Hz)
% Smoothing: Smoothing factor(Default: 1)
% Legend: Display name
%
% ---Variables---
% sp:Power spectra density
% fr:Frequency information
% data:Data to plot PSD
% sr:Sample rate(Unit: Hz)
% sm:Smoothing factor(Default: 1)
% legeng:Display name
% ---Variables---
%
% Data modified: 2021/11/27
% Author: Ouyang

len = length(Data);
overlap = 1;
nfft = 2^(nextpow2(len) - overlap);  %To get a better precise spectral estimate, choose a larger overlap
% nfft = ceil(0.3*length(Data));
% nfft = len;
window = hann(nfft);
[SpectraData,FrequencyInf] = pwelch(Data,window,nfft/2,nfft,SampleRate);  %(SpectraData,window,noverlap,nfft,fs)
spp = sqrt(SpectraData);
if (nargin < 3)
    Smoothing = 1;
    smooth_sp = smooth(spp,Smoothing);
    loglog(FrequencyInf,smooth_sp,'LineWidth',1)
elseif (nargin == 3 && isnumeric(Smoothing))
    smooth_sp = smooth(spp,Smoothing);
    loglog(FrequencyInf,smooth_sp,'LineWidth',1)
elseif (nargin == 3 && ischar(Smoothing))
    Legend = Smoothing;
    Smoothing = 1;
    smooth_sp = smooth(spp,Smoothing);
    loglog(FrequencyInf,smooth_sp,'LineWidth',1,'DisplayName',Legend)
elseif (nargin == 4)
%     Smoothing = 1;
    smooth_sp = smooth(spp,Smoothing);
    loglog(FrequencyInf,smooth_sp,'LineWidth',1,'DisplayName',Legend)
end
% set axis form
    xlabel('Frequency(Hz)')
    ylabel('Amplitude')
    set(gca,'FontSize',20,'LineWidth',1)
    grid on
end

