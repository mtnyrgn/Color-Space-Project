function [z]=selectarea(b)
c=imshow(b);
h=imfreehand(gca);
BW=createMask(h,c);
crp=createMask(h);
d=b;
for i=1:1:size(b,1)
    for j=1:1:size(b,2)
            if BW(i,j)==1
                d(i,j,:)=b(i,j,:);
            end
    end
end
aa1=sum(crp);
aa2=sum(crp');
y1=find(aa1>0,1);
y2=find(aa1>0,1,'last');
x1=find(aa2>0,1);
x2=find(aa2>0,1,'last');
imshow(uint8(d));
rectangle('Position',[y1,x1,y2-y1,x2-x1], 'EdgeColor','yellow');
z=b(x1:x2,y1:y2,:);
end