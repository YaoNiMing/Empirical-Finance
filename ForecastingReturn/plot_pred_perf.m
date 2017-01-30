function plot_pred_perf(pred,r_avg,r_test,test_year,custom_ylim,label)
    l = length(pred(:,1));
    cdsfe = zeros(l,2);
    prev = [0 0];
    for i = 1:l
        avg_err2 = (r_test(i)-r_avg(i))^2;
        cdsfe(i,1) = prev(1) + avg_err2 - (r_test(i) - pred(i))^2;
        cdsfe(i,2) = prev(2) + avg_err2 - (r_test(i) - max(0,pred(i)))^2;
        prev(1) = cdsfe(i,1);
        prev(2) = cdsfe(i,2);
    end
    x_year = test_year:1/12:(test_year+l/12);
    plot(x_year,zeros(length(x_year),1),'color',[0 0 0])
    plot(x_year,[0; cdsfe(:,2)],'color',[0 0 0]+0.4)
    plot(x_year,[0; cdsfe(:,1)],'color',[0 0 0])
    xlim([test_year test_year+l/12]+1/12)
    ylim(custom_ylim)
    title(label)
    set(gca, 'XTick', 1965:10:2015)
end
    