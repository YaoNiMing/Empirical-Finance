function ll = garch_loglik(model,param,y)
    %parameter checking
    assert(ismember(model,{'GARCH','NGARCH','HNGARCH'}),...
        'Model has to be one of ''GARCH'', ''NGARCH'', ''HNGARCH''');
    assert(~(strcmp(model,'GARCH') && length(param)~=4),...
        length(param));
    assert(~(strcmp(model,'NGARCH') && length(param)~=5),...
        'param = [alpha beta omega gamma h1]');
    assert(~(strcmp(model,'HNGARCH') && length(param)~=6),...
        'param = [alpha beta omega lambda gamma h1]');
    if param(3)<=0 || min(param(1),param(2))<0;
       ll=-intmax;
       return;
    end
    %estimate variance process using current parameter values and sp500
    %return data
    ht = var_process(model,param,y);
    if strcmp(model,'GARCH') || strcmp(model,'NGARCH')
        ll = sum(log(normpdf(y,0,sqrt(ht))));
    else
        lmd = param(end-2);
        ll = sum(log(normpdf(y-lmd*ht,0,sqrt(ht))));
    end
end