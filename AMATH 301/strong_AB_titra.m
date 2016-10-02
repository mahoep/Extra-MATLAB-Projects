function p=strong_AB_titra(c,Va,Vb)
acid = c(1);
base = c(2);

g1 = acid.*Va./(Va+Vb)-base.*Vb./(Va+Vb);
g2 = sqrt(g1^.2+4)
p = log(.5*(g1+g2));

end