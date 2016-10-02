
function fout = minfunc(X)

    fout = -[abs(sqrt(2)/(81*sqrt(pi)) .* (6.*X(2) - X(2).^2).* exp(-X(2)/3) .*cos(X(1)))].^2;


end
