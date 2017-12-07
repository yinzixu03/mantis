clc;clear all;close all;
filename='ws.gif';
for i=1:231   %图片数
    I=imread(['E:\mantis\p1\' num2str(i) '.bmp']);
    if i==1;
        imwrite(I,filename,'gif','Loopcount',inf,'DelayTime',0.1);  %loopcount只是在i==1的时候才有用
    else
        imwrite(I,filename,'gif','WriteMode','append','DelayTime',0.05);    %layTime用于设置gif文件的播放快慢
    end
end
