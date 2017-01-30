function plot_pred(pred, r_avg, test_year,custom_ylim,label)
    l = length(pred(:,1));
    x_year = test_year:1/12:(test_year+l/12);
    plot(x_year,zeros(length(x_year),1),'color',[0 0 0]+0.5)
    
    plot(x_year,[0; pred],'color',[0 0 0])
    plot(x_year,[0; r_avg],'color',[0 0 0]+0.7)
    xlim([test_year test_year+l/12]+1/12)
    ylim(custom_ylim)
    title(label)
    set(gca, 'XTick', 1965:10:2015)
end