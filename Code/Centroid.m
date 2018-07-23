function [xm,ym]=Centroid
shpbuild = shaperead('build.shp');
%--------------------------------------------------------------------------

[m n] = size(shpbuild);
max_x=1;
max_y=1;

for j=1:m
   if length(shpbuild(j).X)>max_x
       max_x=length(shpbuild(j).X);
   end
   if length(shpbuild(j).Y)>max_y
       max_y=length(shpbuild(j).Y);
   end
end
x=zeros(m,max_x);
y=zeros(m,max_y);

for i=1:m
    x(i,1:length(shpbuild(i).X))=shpbuild(i).X;
    y(i,1:length(shpbuild(i).Y))=shpbuild(i).Y;
end
[nn n] = size(x);
x = x(:,1:n);
y = y(:,1:n);

for i=1:m
    for j=1:max_x
         A = isnan(x(i,j));
         if A==1;
             r = j;
         end
    end
    xm(i) = mean(x(i,1:r-2));
end
              
for i=1:m
    for j=1:max_y
         A = isnan(y(i,j));
         if A==1;
             r = j;
         end
    end
    ym(i) = mean(y(i,1:r-2));
end
    
% for i= 1:m
%         hold on
%     plot(xm(i),ym(i),'o')
%     end
%--------------------------------------------------------------------------