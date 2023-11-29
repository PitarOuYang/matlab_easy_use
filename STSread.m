function [sige,te,sign,tn,sigz,tz] = STSread(STSNO)
% This function reads the seismic data from STS2.5
%   Caution!!! this function is dependent on .m file rdmseed.m
%   Usage: 
%   [sige,te,sign,tn,sigz,tz] = STSread(STSNO); %
%   STSNO is the serial NO of the STS, normally 6484 or 6485
%   sige, sign, sigz are the seismic data with unit g.
%   t is the datetick(search datetick in matlab help document for detail.)
%   V1.0 Created by: Ouyang in 2023-11-03
%   Modified:
%

[filename,pathname] = uigetfile('*','Please select miniSEED files','Multiselect','on');

X_data = [];
Y_data = [];
Z_data = [];
Tx_data = [];
Ty_data = [];
Tz_data = [];

len = length(filename);
for i = 1:len
    
    data = rdmseed([pathname '\' filename{i}],'simple');
    len1 = length(data);
    for j = 1:len1
        if(data(j).name == ['QT:' num2str(STSNO) '::HLE'])
            X_data = [X_data ; data(j).d];
            Tx_data = [Tx_data ; data(j).t];
            
        end
    end
    for j = 1:len1
        if(data(j).name == ['QT:' num2str(STSNO) '::HLN'])
            Y_data = [Y_data ; data(j).d];
            Ty_data = [Ty_data ; data(j).t];
            
        end
    end
    for j = 1:len1
        if(data(j).name == ['QT:' num2str(STSNO) '::HLZ'])
            Z_data = [Z_data ; data(j).d];
            Tz_data = [Tz_data ; data(j).t];
            
        end
    end 
end

fs=200;%采样率
sige=diff((X_data*20*fs)/(1500*2^23))/9.8;%count数换算成速度值,作微分
sign=diff((Y_data*20*fs)/(1500*2^23))/9.8;
sigz=diff((Z_data*20*fs)/(1500*2^23))/9.8;
te = Tx_data(1:end-1);
tn = Ty_data(1:end-1);
tz = Tz_data(1:end-1);

dateformat = 0;
figure(25)
subplot(3,1,1)
    plot(te,sige)
    title('E')
    ylabel('acceleration(g)')
    datetick('x',dateformat)
    axis([-inf inf -inf inf])
subplot(3,1,2)
    plot(tn,sign)
    title('N')
    ylabel('acceleration(g)')
    datetick('x',dateformat)
    axis([-inf inf -inf inf])
subplot(3,1,3)
    plot(tz,sigz)
    title('Z')
    ylabel('acceleration(g)')
    datetick('x',dateformat)
    axis([-inf inf -inf inf])
end

