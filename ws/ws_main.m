clc;clear all;close all;
fileName = 'D:\mantis\wsvideo\ws.mp4';
obj = VideoReader(fileName);

%每秒对应19.9176帧，根据视频取前11.6秒数据，即231帧
h1=zeros(1,231);    %新建数组用于记录头冠端点所在的行数
h2=zeros(1,231);    %新建数组用于记录头冠端点所在的列数
pic=zeros(140,110,231); %新建矩阵存储二值化的图像

for k=1:231 %k表示该帧图像对应序号
    frame0=read(obj,k);  %读取图像
    frame=rgb2gray(frame0);  %灰度化
    
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
    
    %     %去掉噪点（判断单一黑点外围是否全白，没用上，当摆设）
    %     for i=1:138
    %         for j=1:108
    %             if pic(i,j,k)+pic(i+1,j,k)+pic(i+2,j,k)+pic(i,j+1,k)+pic(i,j+2,k)+pic(i+2,j+1,k)+pic(i+1,j+2,k)+pic(i+2,j+2,k)>1790&&pic(i+1,j+1,k)==0
    %                 pic(i+1,+1,k)=255;
    %             end
    %         end
    %     end
    
    %查找头冠端点位置h1, h2
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
    
    %胫节腿节交汇处jt1, jt2
    i=h1(k)-32;
    j=h2(k)-2;
    jt1(k)=0;
    jt2(k)=0;
    while pic(i,j,k)==255
        i=i-1;
        for j=h2(k)-2:1:h2(k)+30
            if pic(i,j,k)==0
                jt1(k)=i;
                jt2(k)=j;
                break
            end
        end
    end
    if jt1(k)==0
        jt1(k)=jt1(k-1);
        jt2(k)=jt2(k-1);
    end
    
    %腿节转节交汇处tz1, tz2
    i=h1(k)-66;
    j=h2(k)-17;
    while pic(i,j,k)==255
        i=i+1;
        for j=h2(k)-16:1:h2(k)+14
            if pic(i,j,k)==0
                tz1(k)=i;
                tz2(k)=j;
                break
            end
        end
    end
    
    %屁屁pp1, pp2
    i=h1(k)-33;
    j=h2(k)-49;
    while pic(i,j,k)==255
        i=i-1;
        for j=h2(k)-50:1:h2(k)-16
            if pic(i,j,k)==0
                pp1(k)=i;
                pp2(k)=j;
                break
            end
        end
    end
    
    %前足基节jj1, jj2
    jj1(k)=h1(k)-37;
    jj2(k)=h2(k)-9;
    
    %后足基节hj1, hj2
    hj1(k)=h1(k)-70;
    hj2(k)=h2(k)-37;
    
    %二值图转RGB
    b=zeros(140,110,3,231);
    b(:,:,1,k)=pic(:,:,k);
    b(:,:,2,k)=pic(:,:,k);
    b(:,:,3,k)=pic(:,:,k);
    withpoint=zeros(140,110,3,231);
    
    %     %制作黑白版绿圈gif底图
    %     pos=[h2(k),h1(k);jt2(k),jt1(k);tz2(k),tz1(k);pp2(k),pp1(k);jj2(k),jj1(k);hj2(k),hj1(k)];
    %     withpoint(:,:,:,k)=insertMarker(b(:,:,:,k),pos,'o','size',2);
    %     imwrite(withpoint(:,:,:,k),strcat(num2str(k),'.bmp'),'bmp');    %保存帧
    
    %制作彩板绿圈gif底图
    pos=[h2(k)+50,h1(k)+100;jt2(k)+50,jt1(k)+100;tz2(k)+50,tz1(k)+100;pp2(k)+50,pp1(k)+100;jj2(k)+50,jj1(k)+100;hj2(k)+50,hj1(k)+100];
    withpoint(:,:,:,k)=insertMarker(frame0,pos,'o','size',2);
    imwrite(withpoint(:,:,:,k),strcat(num2str(k),'.bmp'),'bmp');    %保存帧
end
