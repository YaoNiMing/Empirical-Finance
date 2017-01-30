function ht = var_process(model,param,y)
    
    alp = param(1);
    bet = param(2);
    omg = param(3);
    lmd = param(end-2);
    gam = param(end-1);
    l = length(y);
    ht = zeros(l,1);
    ht(1) = param(end);
    for i = 2:l
        hrt = sqrt(ht(i-1));
        if strcmp(model,'GARCH')
            ht(i) = omg + bet*ht(i-1) + alp*y(i-1)^2;
        elseif strcmp(model,'NGARCH')
            ht(i) = omg + bet*ht(i-1) + alp*(y(i-1)-gam*hrt)^2;
        else
            ht(i) = omg + bet*ht(i-1) + alp*(y(i-1)/hrt-(lmd+gam)*hrt)^2;
        end
    end
end