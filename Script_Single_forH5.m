function Script_Single_forH5(DIR,FOV_Count,a,b)

%%
%Input 
%DIR = 'F:\Data\ZYX\20220522\Class_1\45Y5Er\'; 

%b = 105;a = 165;

if (~exist('a','var') && ~exist('b','var'))
    b = 105;a = 165;
end
    
%a = 150;b=120;
v=255; 

%%
tic
y1_all = [];y2_all = [];y3_all = [];
y4_all = [];y5_all = [];y6_all = [];
fprintf("-------------Now You are caculating in DIR :%s ! Please Be Patient!\n",DIR)
fprintf("-------------Initial Done!---------------\n")
for i = 1:FOV_Count 
    % load image 
    fprintf('-------------Caculate FOV(%d) ING...........\n',i)
    str= [DIR,'FOV',num2str(i),'\'];
    filename=[str,'afkin_withoutND_500mA.h5'];
    %filename=[fileFolder,fileNames_1{5}];
    s1_1=H5ALL(filename);
    s1_1=s1_1(a:a+v ,b:b+v);
    acqtags=h5read(filename,'/acqtags');
    acqvalues=h5read(filename,'/acqvalues');
    time=acqvalues(1);
    coor = Coor_new(s1_1,5);
    %%
    y1=GaussFit(s1_1(:,:,1),coor,time,4);
    %%
    %Others Power Density
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

    y1_all = [y1_all;y1];y2_all = [y2_all;y2];
    y3_all = [y3_all;y3];y4_all = [y4_all;y4];
    y5_all = [y5_all;y5];y6_all = [y6_all;y6];
    clear y1 y2 y3 y4 y5 y6 coor        
    fprintf('-------------Caculate FOV(%d) Ok!---------------\n',i)
end

csvwrite([DIR,'Intensity_withoutND_Fit1_all.csv'],y1_all)
csvwrite([DIR,'Intensity_withoutND_Fit2_all.csv'],y2_all)
csvwrite([DIR,'Intensity_withoutND_Fit3_all.csv'],y3_all)
csvwrite([DIR,'Intensity_withoutND_Fit4_all.csv'],y4_all)
csvwrite([DIR,'Intensity_withoutND_Fit5_all.csv'],y5_all)
csvwrite([DIR,'Intensity_withoutND_Fit6_all.csv'],y6_all)
clear all
fprintf('-------------Well Done!---------------\n')
toc
end