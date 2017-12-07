clc;clear all;close all;
fileName = 'E:\mantis\ws\ws.mp4';
obj = VideoReader(fileName);

%每秒对应19.9176帧，根据视频取前11.6秒数据，即231帧
h1=zeros(1,231);    %新建数组用于记录头冠端点所在的行数
h2=zeros(1,231);    %新建数组用于记录头冠端点所在的列数

for k=1:231 %k表示该帧图像对应序号
    frame=read(obj,k);  %读取图像
    frame=rgb2gray(frame);  %灰度化
    pic=zeros(140,110,231); %新建矩阵存储二值化的图像
    
    %人工提取需求点进行二值化
    for i=101:240   %截取对应高度
        for j=51:160    %截取对应宽度
            if frame(i,j)<100   %以灰度值100作为一个判断界值
                pic(i-100,j-50,k)=0;    %灰度值小于100为黑色
            else
                pic(i-100,j-50,k)=255;  %灰度值大于等于100为白色
            end
        end
    end
    a1=pic(:,:,k);
    %imshow(pic(:,:,k)); %显示帧
    %imwrite(pic(:,:,k),strcat(num2str(k),'.bmp'),'bmp');    %保存帧
    
    %查找头冠端点位置
    for i=140:-1:51 %行数大概区域范围
        for j=90:-1:30 %列数大概区域范围
            if pic(i,j,k)==0    %判断是否为黑色
                h1(k)=i;    %记录头冠端点所在的行数
                h2(k)=j;    %记录头冠端点所在的列数
                break
            end
        end
        if h1(k)~=0 %用于跳出第二层循环
            break
        end
    end
