function error=rms(y,c,t,fun,k) 
error = sqrt(1/length(t)*sum(y-fun(c,k,t).^2));
