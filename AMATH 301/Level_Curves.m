% random_surf:  Generates a random (fractal) surface over the unit square.
tic
%               Comment out the standard code (line 13) and uncomment the
%               cylinder code (line 16) with %-signs to change the output.

res = 250; % # of lattice points, raise for higher resolution
n = 100;     % # of superposed functions, raise for a more complex surface
[X,Y] = meshgrid(linspace(0,1,res),linspace(0,1,res));
S = zeros(size(X));
for kay = 1:n
    for jay = 1:n
        % this is the standard code for a random 2-D surface
        S = S + randn*sin(pi*jay*X).*sin(pi*kay*Y)/(pi*(kay^2+jay^2));
    end
    % this is the code for a random (right) cylinder parallel to the Y axis
     % S = S + randn*sin(pi*kay*X)/(pi*kay^2)^(0.7);
end
cmap = colormap('winter');
h = meshc(X,Y,S);
levels = 1;
h(2).LevelStep = h(2).LevelStep/levels;
view(0,90)
axis equal % off
colorbar
% 
 figure
contour(S,'LevelStep',0.01)
toc