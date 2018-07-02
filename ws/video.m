clc;clear all;close all;
videoName = 'wscolor.avi';%表示将要创建的视频文件的名字
fps = 20; %帧率

%把之前的视频覆盖（没啥卵用，鲁棒性而已）
if(exist('videoName','file'))
    delete videoName.avi
end

%生成视频的参数设定
aviobj=VideoWriter(videoName);  %创建一个avi视频文件对象，开始时其为空
aviobj.FrameRate=fps;

open(aviobj);%打开空视频等待写入数据

%读入图片
for i=1:231
    frames=imread(['D:\mantis\p3\' num2str(i) '.bmp']);
    writeVideo(aviobj,frames);
end

close(aviobj);% 关闭创建视频
