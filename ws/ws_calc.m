%save('cfit_Fourier','fittedmodel1','fittedmodel2','fittedmodel3');  %�洢cftool�����������
clc;clear all;close all;
load('cfit_Fourier');  %����cftool�����������
load('location');
for i=1:150
    a(i)=sqrt((pp1(i)-hj1(i))^2+(pp2(i)-hj2(i))^2);  %ƨƨ�ͺ�����ھ���
    b(i)=sqrt((jj1(i)-hj1(i))^2+(jj2(i)-hj2(i))^2);  %ǰ����ںͺ�����ھ���
    c(i)=sqrt((pp1(i)-jj1(i))^2+(pp2(i)-jj2(i))^2);  %ǰ����ں�ƨƨ����
    
    angle(i)=asind((a(i)^2+b(i)^2-c(i)^2)/(2*a(i)*b(i)));  %��ýǶ�
end

%��cftool�������õ�
x=1:50;
y1=angle(1:50);
y2=angle(44:93);
y3=angle(101:150);

subplot(3,1,1);
plot(x,y1,'*r');
grid on;
hold on;
plot(fittedmodel1);

subplot(3,1,2);
plot(x,y2,'*r');
grid on;
hold on;
plot(fittedmodel2);

subplot(3,1,3);
plot(x,y3,'*r');
grid on;
hold on;
plot(fittedmodel3);
