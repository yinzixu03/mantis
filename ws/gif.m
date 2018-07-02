clc;clear all;close all;
filename='ws.gif';
for i=1:231   %图片数
    I=imread(['D:\mantis\p2\' num2str(i) '.bmp']);
    %[P,map]=rgb2ind(I,256,'dither');   %RGB图转换为索引图（制作GIF只能用2或者4波段数据）
    if i==1;
        imwrite(P,map,filename,'gif','Loopcount',inf,'DelayTime',0.1);  %loopcount只是在i==1的时候才有用
    else
        imwrite(P,map,filename,'gif','WriteMode','append','DelayTime',0.05);    %layTime用于设置gif文件的播放快慢
    end
end
