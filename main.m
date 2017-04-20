train_data = csvread('meraged_20min_avg_travel_time.csv') ;
test_data = csvread('test_meraged_20min_avg_travel_time.csv') ;
train_data_x = train_data(:,1:end-1) ;
train_data_y = train_data(:,end) ;
test_data_x = test_data(:,1:end-1) ;
test_data_y = test_data(:,end) ;
%mape = sum(abs(test_data_y-predict_y)./test_data_y)/length(test_data_y) ;
%disp([test_data_y predict_y]) ;
%disp(mape) ;
rans = 0 ;
for i=1:50
    temp_train_data = sampleWithReplace(train_data) ;
    temp_train_data_x = temp_train_data(:,1:end-1) ;
    temp_train_data_y = temp_train_data(:,end) ;
    ensemble = fitensemble(temp_train_data_x,temp_train_data_y,'LSBoost',1000,'Tree','LearnRate',0.1) ;
    predict_y = predict(ensemble,test_data_x) ;
    rans = rans+sum(abs(test_data_y-predict_y)./test_data_y)/length(test_data_y) ;
end
disp(rans/50) ;