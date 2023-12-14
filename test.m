Data = rand(100000,1);
SampleRate = 200;

len = length(Data);
overlap = 1;
nfft = 2^(nextpow2(len) - overlap);  %To get a better precise spectral estimate, choose a larger overlap
% nfft = ceil(0.3*length(Data));
% nfft = len;
window = hann(nfft);
[SpectraData,FrequencyInf] = pwelch(Data,window,nfft/2,nfft,SampleRate);  %(SpectraData,window,noverlap,nfft,fs)
spp = sqrt(SpectraData);

loglog(FrequencyInf,spp)
grid on
bandpowerlen = 1000;
bandpowerFreq = log(log10(FrequencyInf(1)),log10(FrequencyInf(end)),bandpowerlen);
for i = 1:bandpowerlen
    
end
