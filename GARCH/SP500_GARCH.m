%% Comparison of Different GARCH models on SP500 Total return
% The GARCH models being compared are GARCH, NGARCH, and HNGARCH models
% The parameters are estimated using MLE and then the normality of
% residuals are checked.

dbtype garch_loglik.m
dbtype var_process.m

%obtaining SP500 total return 
raw_data = csvread('SP500TR_1992_2016.csv',1,1);
sp500tr = log(raw_data(end-1:-1:1,6)./raw_data(end:-1:2,6));


%parameter MLE
options=optimset('MaxFunEvals',1000,'Maxiter',1000,'Display','iter','LargeScale','off');
%GARCH model
garch_param = fmincon(@(param)-garch_loglik('GARCH',param,sp500tr),...
    [0.1,0.8,0.1,std(sp500tr(1:100))],[],[],[],[],zeros(4,1),[],[],options);
garch_ht = var_process('GARCH',garch_param,sp500tr);
garch_zt = sp500tr./sqrt(garch_ht);

%NGARCH 
ngarch_param = fmincon(@(param)-garch_loglik('NGARCH',param,sp500tr),...
    [0.1,0.8,0.1, 0.1,std(sp500tr(1:100))],[],[],[],[],zeros(5,1),[],[],options);
ngarch_ht = var_process('NGARCH',ngarch_param,sp500tr);
ngarch_zt = sp500tr./sqrt(ngarch_ht);

%HNGARCH
hngarch_param = fmincon(@(param)-garch_loglik('HNGARCH',param,sp500tr),...
    [0.1,0.8,0.1, 0.1, 0.1,std(sp500tr(1:100))],[],[],[],[],zeros(6,1),[],[],options);
hngarch_ht = var_process('HNGARCH',hngarch_param,sp500tr);
hngarch_zt = (sp500tr-hngarch_param(4)*hngarch_ht)./sqrt(hngarch_ht);


figure(1)
set(gcf,'units','centimeters','position',[0 0 30 20])
subplot(2,3,1)
stem(autocorr(garch_zt.^2))
title('ACF of GARCH(1,1) Squared Residual')
xlabel('lag')
subplot(2,3,4)
qqplot(garch_zt)
title('GARCH(1,1) Residual Normal-QQ')
subplot(2,3,2)
stem(autocorr(ngarch_zt.^2))
title('ACF of NGARCH(1,1) Squared Residual')
xlabel('lag')
subplot(2,3,5)
title('NGARCH(1,1) Residual Normal-QQ')
qqplot(ngarch_zt)
subplot(2,3,3)
stem(autocorr(hngarch_zt.^2))
title('ACF of HN-GARCH(1,1) Squared Residual')
xlabel('lag')
ylim([-0.2 1.2])
subplot(2,3,6)
title('HN-GARCH(1,1) Residual Normal-QQ')
qqplot(hngarch_zt)

%raw return and squared returns ACF and raw return nomal QQ plot
figure(2)
subplot(2,2,1)
stem(autocorr(sp500tr))
title('ACF of Raw Total Return on SP500')
xlabel('lag')
subplot(2,2,3)
qqplot(sp500tr)
title('Raw Total Return Normal-QQ')
subplot(2,2,2)
stem(autocorr(sp500tr.^2))
title('ACF of Squared Total Return on SP500')
xlabel('lag')