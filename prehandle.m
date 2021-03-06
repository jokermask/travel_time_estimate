origin_data_file = fopen('./dataSets/predicting/submission_sample_travelTime.csv') ;
or_data_labels = textscan(origin_data_file, '%s %s %s %s',1,'Delimiter',',' ) ;
od_cells = textscan(origin_data_file, '%q %q %q %q','Delimiter',',');  
fclose(origin_data_file);
weather_data_file = fopen('./dataSets/testing_phase1/weather_test1.csv') ;
wd_data_labels = textscan(weather_data_file, '%s %s %s %s %s %s %s %s %s',1,'Delimiter',',') ;
wd_cells = textscan(weather_data_file, '%q %q %q %q %q %q %q %q %q','Delimiter',',');  
fclose(weather_data_file) ;
%wd_data第一列是日期字符
wd_cells{1} = datestr(wd_cells{1},29) ;%yyyy-mm-dd
for i=2:length(wd_cells)
    wd_cells{i} = str2double(wd_cells{i}) ;
end
%将A,B,C数据化
intersection_id = cell2mat(od_cells{1}) ;
intersection_num = zeros(length(intersection_id),1) ;
intersection_num(intersection_id=='A') = 1 ;
intersection_num(intersection_id=='B') = 2 ;
intersection_num(intersection_id=='C') = 3 ;
od_cells{1} = intersection_num ;
%对比时间，和weather表合并
%sample [2016-07-19 00:00:00,2016-07-19 00:20:00)
time_window = cell2mat(od_cells{3}) ;
disp(wd_cells{2}(2)) ;
for i=1:length(time_window)
    temp_window = time_window(i,:) ;
    ymd_data = datestr(temp_window(2:11),29) ;
    [weekdaynum,~] = weekday(ymd_data) ;
    hour_data = str2num(temp_window(13:14)) ;
    min_data = str2num(temp_window(16:17)) ;

    
    %第五列表示星期几
    od_cells{5}(i,:) = weekdaynum ;
    
    wd_ymd_data = wd_cells{1} ;
    for j=1:length(wd_ymd_data) 
        if strcmp(wd_ymd_data(j,:), ymd_data) 
            if (hour_data - wd_cells{2}(j))<=3
                for k=3:9
                    od_cells{k+3}(i,:) = wd_cells{k}(j,:) ;
                end
                break ;
            end
        end
    end
    od_cells{3}(i,:) = {num2str(60*hour_data+min_data)} ;%这里又转回str是因为要和第二列和第四列一起处理
end
%最后将od_cells中的2~4也转成浮点好弄成矩阵
for i=2:4
    od_cells{i} = str2double(od_cells{i}) ;
end
train_data = cell2mat(od_cells) ;
train_data = [train_data(:,1:3) train_data(:,5:12) train_data(:,4)];%将预测值放到最后一列
csvwrite('submit_meraged_20min_avg_travel_time.csv',train_data) ;