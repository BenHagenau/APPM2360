[x,y]=meshgrid(-5:.5:5,-5:.5:5);
dy = .14*y - 750;
dx = ones(size(dy));
dyu = dy./sqrt(dx.^2+dy.^2);
dxu = dx./sqrt(dx.^2+dy.^2);
quiver(x,y,dxu,dyu)

