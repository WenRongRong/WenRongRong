clc
close all
clear 
%%
file = 'G:\Data\ZYX\xEr(1-x)Yb_outside_in\ReCheck\10Er_211121\new\FOV1\afkin_withoutND_500mA.h5';
s1_1=H5ALL(file);
imshow(s1_1,[])
b = 120;a = 90;v=255;
s1_1=s1_1(a:a+v ,b:b+v);
figure(2)
imshow(s1_1,[])
%%
DIR_list = {'G:\Data\ZYX\xEr(1-x)Yb_outside_in\ReCheck\10Er_221006\','G:\Data\ZYX\xEr(1-x)Yb_outside_in\ReCheck\80Yb10Er10Ga\'};
for i =1:size(DIR_list,2)
    DIR = DIR_list(i);
    Script_Single_forH5(DIR{1},5,a,b)
end

