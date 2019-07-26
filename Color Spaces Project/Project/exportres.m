function [sheet] = exportres(sav,sheet,name)


if size(sav,3)==1
else
h=sav(:,:,1);
s=sav(:,:,2);
v=sav(:,:,3);
end

filename = 'results.xlsx';

xlRange = 'C2';
if size(sav,3)==1
    xlswrite(filename,sav,sheet,xlRange)
    xlswrite(filename,name(1),sheet,'A1')
else
xlswrite(filename,h,sheet,xlRange)
xlswrite(filename,s,sheet+1,xlRange)
xlswrite(filename,v,sheet+2,xlRange)
xlswrite(filename,name(1),sheet,'A1')
xlswrite(filename,name(2),sheet+1,'A1')
xlswrite(filename,name(3),sheet+2,'A1')
sheet=sheet+2;
end

end

