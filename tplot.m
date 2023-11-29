function t = tplot(DATA,SAMPLERATE,TIMETYPE)
%TPLOT Plot TimeSeries of the input data
% --------------------Usage--------------------
% TPLOT(DATA,SAMPLERATE,TIMETYPE) plots the DATA with timeseries
% 
% -------------INPUTS and OUTPUTS--------------
% DATA : data to plot
% SAMPLERATE : sample rate (unit: Hz)
% TIMETYPE : 's' for second, 'm' for minute, 'h' for hour, 'd' for day
% The function returns the TimeLine of the data
% Create Time : 2021.12.29
% Author : OoO

len = length(DATA);
timesacle = 1;
TimeTypeChar = 's';
if(nargin < 3)
    timesacle = 1;
elseif(nargin == 3)
    switch TIMETYPE
        case 's'
        case 'm'
            timesacle = 60;
            TimeTypeChar = 'min';
        case 'h'
            timesacle = 60*60;
            TimeTypeChar = 'hour';
        case 'd'
            timesacle = 60*60*24;
            TimeTypeChar = 'day';
        otherwise
            warning('Unexpected time type')
    end
else
    warning('Too many input arguments')
end
    t = linspace(0,len/SAMPLERATE/timesacle,len);
    plot(t,DATA)
    xlabel(['Time(' TimeTypeChar ')'])
    ylabel('Amplitude')
    set(gca,'FontSize',20,'LineWidth',1)
    grid on
    axis([-inf inf -inf inf])
end

