origin_data_file = fopen('./dataSets/training/training_20min_avg_travel_time.csv') ;
or_data_labels = textscan(origin_data_file, '%s %s %s %s',1,'Delimiter',',' ) ;
od_cells = textscan(origin_data_file, '%s %s %s %s','Delimiter',',');  
fclose(origin_data_file);
weather_data_file = fopen('./dataSets/training/weather (table 7)_training_update.csv') ;
wd_data_labels = textscan(weather_data_file, '%s %s %s %s %s %s %s %s %s',1,'Delimiter',',') ;
wd_cells = textscan(weather_data_file, '%s %s %s %s %s %s %s %s %s','Delimiter',',');  
fclose(weather_data_file) ;
%origin_data = cell2mat(od_cells); 
%weather_data = cell2mat(wd_cells); 
disp('done') ;
% for i=1:len(origin_data)
%     origin_data(i)