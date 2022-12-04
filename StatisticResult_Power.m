%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1.data preprocessing                                                     %
%2.remove outliers                                                        %
%3.Statistics output   
%4.save
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc
close all
clear
%%
%需要更改的部分
dir = 'G:\Data\ZYX\xEr(1-x)Yb_outside_in\ReCheck\80Yb10Er10Ga\';
Dirname = '80Yb10Er10Ga'; %样品名标记



%%
Statistic_result = zeros(6,4);
for Power_k = 1:6
    filename = strcat(dir,'Intensity_withoutND_Fit',num2str(Power_k),'_all.csv');
    data_raw = load(filename);
    Intensity_raw = data_raw(:,3);

    % 
    if Power_k==1
        index = data_raw(:,5)>4.5| data_raw(:,4)>4.5|  data_raw(:,3) <0;
        Intensity_raw(index) =[];
    else
        %去除小于0
        Intensity_raw(Intensity_raw<0)=[];
    end
        
    %MAD
    [Intensity,TF] = rmoutliers(Intensity_raw,'median');
    %四分位
    [Intensity,TF] = rmoutliers(Intensity,'quartiles');

    %Statistics
    pd = fitdist(Intensity,'Normal');
    Mean = pd.mu;
    Std  = pd.sigma;
    Median = median(Intensity,'all');
    number = size(Intensity,1);
    Statistic_result(Power_k,:)=[Mean,Std,Median,number];
    %绘图保存
    fig = figure;
    h = histfit(Intensity)
    h(1).FaceColor =[.8 .8 1];
    xlabel('Intensity(pps)','FontSize',18)
    ylabel('Counts','FontSize',18)
    title(strcat(Dirname,'power',num2str(Power_k)),'FontSize',16)
    
    legend(strcat('Mean:',num2str(Mean), ';Std:',num2str(Std)));
    frame = getframe(fig); % 获取frame
    img = frame2im(frame); % 将frame变换成imwrite函数可以识别的格式
    imwrite(img,strcat(dir,num2str(Power_k),'.tif'));
    close all
end

%保存
T = array2table(Statistic_result,'VariableNames',{'Mean','Std','CMedian','Number'});
writetable(T,strcat(dir,Dirname,'.xls'))
%%
plot(data_raw(:,5),data_raw(:,4),'*')







