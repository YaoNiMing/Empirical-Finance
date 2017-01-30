%% Daily RV from SP500 data
% Uses a average sparse RV calculation method from minute data

load('SP500INDEX_LNR_INTRADAY1MIN_2004_2013.mat')
group = 5; %sparse lag = 5

processed = 1;
l = length(sp500ret);
i = 1;
rv = zeros(length(unique(sp500ret(:,1))),1);
dates = zeros(length(rv),1);
rvg = zeros(group,1);
while processed < l
    di = sp500ret(processed,1);
    reti = sp500ret(processed+g:processed+384+g,3);
    for g = 1:group
        retig = sum(reshape(reti,5,length(reti)/5),1);
        rvg(g) = sum(retig.^2);
    end
    rv(i) = mean(rvg);
    dates(i) = di;
    i = i+1;
    processed = processed+390;
end
dates = datenum(int2str(dates),'yyyymmdd');
plot(dates,rv)
datetick('x','keepticks','keeplimits')
xlim([min(dates) max(dates)])