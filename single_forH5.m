
%% 
clc
clear 
close all 
%%
%读取图像文件
str= ['F:\Data\ZYX\2022603_response\class_2\5Er\FOV',num2str(5),'\'];
filename=[str,'afkin_withoutND_500mA.h5'];
%filename=[fileFolder,fileNames_1{5}];
s1_1=H5ALL(filename);
a = 150;b=120;v=255;
s1_1=s1_1(a:a+v ,b:b+v);
acqtags=h5read(filename,'/acqtags');
acqvalues=h5read(filename,'/acqvalues');
time=acqvalues(1);
%s1_x=s1_1/time;
%s1_x = s_photon(:,:,1)./exposure_time;
coor = Coor_new(s1_1,5);
%%
imagesc(s1_1);
hold on
%plot(coor(:,2),coor(:,1),'r.','MarkerSize',10)
plot(coor(:,2),coor(:,1),'ro','MarkerSize',10);
hold off
%%
y1=GaussFit(s1_1(:,:,1),coor,time,4);
    %% 显示最终结果
    figure(1)
    imagesc(s1_1);
    idlbar(6)
    colorbar
    hold on
    plot(y1(:,2),y1(:,1),'ro','MarkerSize',10);
    
    for i=1:size(y1,1)
        text(y1(i,2)+1,y1(i,1)+1,['[No',num2str(i),']',num2str((y1(i,3)/1000)),'k'],'Color','r','FontSize',9);
    end

    hold off
    axis off

%%
%处理其他功率
%Without ND 
filename1_2=[str,'afkin_withoutND_300mA.h5'];
filename1_3=[str,'afkin_withoutND_188mA.h5'];filename1_4=[str,'afkin_withoutND_128mA.h5'];
filename1_5=[str,'afkin_withoutND_100mA.h5'];filename1_6=[str,'afkin_withoutND_85mA.h5'];

s1=zeros(size(s1_1,1),size(s1_1,2),6);
image =H5ALL(filename1_2);s1(:,:,2) =image(a:a+v ,b:b+v);
image =H5ALL(filename1_3);s1(:,:,3) =image(a:a+v ,b:b+v);
image =H5ALL(filename1_4);s1(:,:,4) =image(a:a+v ,b:b+v);
image =H5ALL(filename1_5);s1(:,:,5) =image(a:a+v ,b:b+v);
image =H5ALL(filename1_6);s1(:,:,6) =image(a:a+v ,b:b+v);

acqvalues1_2=h5read(filename1_2,'/acqvalues');
acqvalues1_3=h5read(filename1_3,'/acqvalues');acqvalues1_4=h5read(filename1_4,'/acqvalues');
acqvalues1_5=h5read(filename1_5,'/acqvalues');acqvalues1_6=h5read(filename1_6,'/acqvalues');

time1=zeros(6,1);
time1(1)=acqvalues(1);time1(2)=acqvalues1_2(1);time1(3)=acqvalues1_3(1);
time1(4)=acqvalues1_4(1);time1(5)=acqvalues1_5(1);time1(6)=acqvalues1_6(1);


y2=GaussFit(s1(:,:,2),coor,time1(2),4);
y3=GaussFit(s1(:,:,3),coor,time1(3),4);
y4=GaussFit(s1(:,:,4),coor,time1(4),4);
y5=GaussFit(s1(:,:,5),coor,time1(5),4);
y6=GaussFit(s1(:,:,6),coor,time1(6),4);


csvwrite([str,'Intensity_withoutND_y1.csv'],y1)
csvwrite([str,'Intensity_withoutND_y2.csv'],y2)

csvwrite([str,'Intensity_withoutND_y3.csv'],y3)
csvwrite([str,'Intensity_withoutND_y4.csv'],y4)
csvwrite([str,'Intensity_withoutND_y5.csv'],y5)
csvwrite([str,'Intensity_withoutND_y6.csv'],y6)
% %%
A1=load('F:\Unknown\GL\FOV1\Intensity_withoutND_y5.csv');
A2=load('F:\Unknown\GL\FOV2\Intensity_withoutND_y5.csv');
A3=load('F:\Unknown\Gl\FOV3\Intensity_withoutND_y5.csv');
A4=load('F:\Unknown\Gl\FOV4\Intensity_withoutND_y5.csv');
A5=load('F:\Unknown\ZN-2\FOV5\Intensity_withoutND_y6.csv');
% A6=load('F:\Unknown\ZN-1\FOV6\Intensity_withoutND_y6.csv');

y_all = [A1(:,3);A2(:,3);A3(:,3);A4(:,4);A5(:,3)];
% id = y_all >3*median(y_all );
% y_all (id) = [];
% id = y_all < 0.1* median(y_all );  
% y_all (id) = [];
histogram(A5(:,3))
xlabel('Intensity(pps)','FontSize',16)
ylabel('Counts','FontSize',16)
y_all=A5(:,3);
axis([0 5000 -inf inf])
set(gca,'xtick',0:1000:5000)
id = y0(:,3)>3*median(y0(:,3));
y0(id)= [];
id = y_all < 0.2* median(y_all );  
y_all (id) = [];
mean(y_all)
std(y_all)
mean(A5(:,3))
std(A5(:,3))
%%

