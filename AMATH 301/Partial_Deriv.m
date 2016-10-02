%pardiff - partial differentiator

res = 300; % resolution of the surface
a1 = -2; b1 = -0.5;  % point (a,b) is where the partial derivative is evaluated
a2 = 1; b2 = b1;  % second point defining secant line (this will approach (a,b))

% surface definition
func = @(x,y)((1/3).*(3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ... 
   - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ... 
   - 1/3*exp(-(x+1).^2 - y.^2)));

% plot formatting
h = figure;
title('x-partial derivative of a surface.')
h.Position = [1 39 1536 749];
[X,Y] = meshgrid(linspace(-3,3,res),linspace(-3,3,res));
subplot(1,2,1)
the_surf = surf(X,Y,func(X,Y),'FaceAlpha',0.8,'EdgeColor','interp');
hold on
scatter3(a1,b1,func(a1,b1))
the_pt = scatter3(a2,b2,func(a2,b2),'filled');
xlabel('X')
ylabel('Y')

% plane giving the cross-section
planeY = repmat(b1,size(Y));
Z = repmat(linspace(-3,3,res),res,1);
surf(X,planeY,Z','FaceAlpha',0.3,'EdgeColor','none','FaceColor',[0 0.5 1])
colormap bone
axis equal

% the cross-section itself
plot3(X(1,:),repmat(b1,1,res),func(X(1,:),b1),'Color','black','LineWidth',2)
axis manual

% initial secant line stored in ell
shlope = (func(a2,b2) - func(a1,b1))/norm([a2,b2]-[a1,b1]);  % rise over run
ell = line([-3,3],[b1,b2],[shlope*(-3-a1)+func(a1,b1),shlope*(3-a1)+func(a1,b1)],'Color','green','LineWidth',2);
pause(1)

% line parameter is identical with X coordinate
t = linspace(-3,3,res);
hold off

% cross-section view
subplot(3,2,4)
plot(X(1,:),func(X(1,:),b1),'Color','black','LineWidth',2)
hold on
axis equal manual
scatter(a1,func(a1,b1))
ell2 = line([-3,3],[shlope*(-3-a1)+func(a1,b1),shlope*(3-a1)+func(a1,b1)],'Color','green');
the_pt2 = scatter(a2,func(a2,b2),'filled');
txt_out = annotation('textbox',[0.8,0.2,0.1,0.1],'String',['Slope is ',num2str(shlope),'.']);
hold off
for ind = 1:(res-1)
    anew = (a2 - a1)*(1-ind/res) + a1; bnew = (b2 - b1)*(1-ind/res) + b1;
    shlope = (func(anew,bnew) - func(a1,b1))/norm([anew,bnew]-[a1,b1]);
    % ell.XData = [-3,3];
%     ell.YData = [b1, b1];
    ell.ZData = [shlope*(-3-a1)+func(a1,b1),shlope*(3-a1)+func(a1,b1)];
    ell2.YData = [shlope*(-3-a1)+func(a1,b1),shlope*(3-a1)+func(a1,b1)];
    the_pt.XData = anew; the_pt.YData = bnew; the_pt.ZData = func(anew,bnew);
    the_pt2.XData = anew; the_pt2.YData = func(anew,bnew);
    txt_out.String = ['Slope is ',num2str(shlope),'.'];
    pause(8/res)
end