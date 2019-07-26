function [z]=selectpoint(b)
c=imshow(b);
h=impoint(gca);
BW=createMask(h,c);
crp=createMask(h);

for i=1:1:size(b,1)
    for j=1:1:size(b,2)
            if BW(i,j)==1
                d=b(i,j,:);
            end
    end
end
z=d;

    answer = questdlg('Would you like to select a new point', ...
	'Multi-dots selection', ...
	'Yes','No','Restart');
    
    % Handle response
    switch answer
    case 'Yes'
        d=selectpoint(b);
        z=[z;d];
    case 'No'
        
    case 'Restart'
        z=selectpoint(b);        
    end
end