function plot_troughs(troughs)
    for tx = 1:length(troughs)
        trough_begin = round(troughs(tx,1)/100)+mod(troughs(tx,1),100)/12;
        trough_end = round(troughs(tx,2)/100)+mod(troughs(tx,2),100)/12;
        
        p = patch([trough_begin trough_end trough_end trough_begin],...
            [-3 -3 2 2],[0 0 0] + 0.85);
        %set(p, 'FaceAlpha', 0.6)
        set(p, 'LineStyle', 'none')
    end
    set(gca,'children',flipud(get(gca,'children')))
end