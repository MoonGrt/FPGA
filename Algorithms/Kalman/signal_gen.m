%-------------产生一批带噪数据------------------
clc,clear,close all

t=linspace(0,10,1024);
noise=0.2*randn(size(t)); %过程噪声
%data=sin(t)+3*sin(0.2*t+pi/3)+0.3*sin(3*t)+sin(10*t)+noise;
data=(t>5)+noise;

data=data-min(data);
data=data./max(data);
data=floor(data*65535);

plot(t,data)

% fid=fopen('data_noised.hex','w');
% for k=1:1024
%     fprintf(fid,[dec2hex(data(k)),'\n']); %16进制文件
% end
% fclose(fid);
