function pred = predict_r(X,y,test_idx)
    l = length(X);
    const_ones = ones(l,1);
    pred = zeros(l-test_idx+1,1);
    for i = 1: l-test_idx+1
        hist_l = test_idx-2+i;
        beta = regress(y(2:hist_l),[const_ones(1:hist_l-1) X(1:hist_l-1,:)]);
        pred(i) = [1 X(hist_l,:)]*beta;
    end

end