train_data_1 = csvread('meraged_20min_avg_travel_time.csv') ;
train_data_2 = csvread('test_meraged_20min_avg_travel_time.csv') ;
test_data = csvread('submit_meraged_20min_avg_travel_time.csv') ;
train_data = [train_data_1;train_data_2] ;
train_data_x = train_data(:,1:end-1) ;
train_data_y = train_data(:,end) ;
test_data_x = test_data(:,1:end-1) ;
test_data_y = test_data(:,end) ;
ensemble = fitensemble(train_data_x,train_data_y,'LSBoost',100,'Tree') ;
predict_y = predict(ensemble,test_data_x) ;
disp(predict_y) ;
mape = sum(abs(test_data_y-predict_y)./test_data_y)/length(test_data_y) ;
disp(mape) ;