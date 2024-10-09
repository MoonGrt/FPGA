%-----------FIR滤波器参数(生成.v)-----------------
clc,clear,close all

fs=1e6;

N=20;
Wn=0.1;
b = fir1(N, Wn); % 默认Hamming窗

freqz(b,1,512)

%% pramas
B=floor(b*65536);
B=B';

%% test
t=0:1/fs:1e-3;
s=(mod(t,1e-4)<5e-5)*1.0;

%s_filt=filter(B,1,s)/65536;
for i=1:size(s,2)-N-1
    s_filt(i)=s(i:i+N)*double(B)/65536;
end

figure
subplot(2,1,1)
plot(t,s)
subplot(2,1,2)
plot(t(1:end-N-1),s_filt)

%% 生成.v
filename='FIR_params';
fid=fopen(['./v/',filename,'.v'],'w');

fprintf(fid,['/* ','\n',...
' * file\t\t\t: ',filename,'.v','\n',...
' * author\t\t: 今朝无言','\n',...
' * date\t\t\t: 2023-07-04','\n',...
' * version\t\t: v1.0','\n',...
' * description\t: FIR 滤波器','\n',...
' */','\n']);

fprintf(fid,['module ',filename,'(','\n',...
'output\t[',num2str(size(B,1)*16-1),':0]\tparams\n',...
');\n\n']);

for i=1:size(B,1)
    if(B(i)>=0)
        hex=dec2hex(B(i),4);
    else
        hex=dec2hex(65536+B(i),4);
    end
    fprintf(fid,['assign\t','params[',...
        num2str(i*16-1),':',num2str((i-1)*16),...
        ']\t= 16','''','h',hex,';\n']);
end

fprintf(fid,'\nendmodule\n');

fclose(fid);
