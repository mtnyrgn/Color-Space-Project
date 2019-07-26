clc
clear

hFig=figure('Position',[200 200 1600 600]);
      movegui(hFig,'center')  ;
% hp = uipanel('Title','Check the color spaces','FontSize',12,...
%              'BackgroundColor','white',...
%              'Position',[.01 .01 .5 .9]);
% hp2 = uipanel('Title','First Panel','FontSize',12,...
%              'BackgroundColor','white',...
%              'Position',[.51 .01 .5 .9]);
ButtonH=uicontrol('Parent',hFig,'Style','pushbutton','String','Browse','fontsize',12,'Units','normalized','Position',[0.89 0.9 0.1 0.1],'Visible','on');
ButtonH.Callback=@brws;
ButtonR=uicontrol('Parent',hFig,'Style','pushbutton','String','Reset Figure','fontsize',12,'Units','normalized','Position',[0.79 0.9 0.1 0.1],'Visible','on');
ButtonR.Callback=@rs;
ButtonA=uicontrol('Parent',hFig,'Style','pushbutton','String','Select','fontsize',12,'Units','normalized','Position',[0.69 0.9 0.1 0.1],'Visible','on');
ButtonA.Callback=@ws;
P1=uicontrol('Parent',hFig,'Style','popupmenu','String',{'All Area','Free selection','Multi dots','Elliptic Area', 'Rectangle Area'},'Units','normalized','FontSize',14,'Position',[0.33 0.9 0.1 0.1],'Visible','on');
ButtonC=uicontrol('Parent',hFig,'Style','pushbutton','String','Save Selected Results','fontsize',12,'Units','normalized','Position',[0.59 0.9 0.1 0.1],'Visible','on');
ButtonC.Callback=@sv;
P2=uicontrol('Parent',hFig,'Style','checkbox','String','RGB','Units','normalized','FontSize',14,'Position',[0.01 0.95 0.1 0.05],'Visible','on');
P3=uicontrol('Parent',hFig,'Style','checkbox','String','YIQ','Units','normalized','FontSize',14,'Position',[0.01 0.85 0.1 0.05],'Visible','on');
P4=uicontrol('Parent',hFig,'Style','checkbox','String','HSV','Units','normalized','FontSize',14,'Position',[0.11 0.95 0.1 0.05],'Visible','on');
P5=uicontrol('Parent',hFig,'Style','checkbox','String','YCbCr', 'Units','normalized','FontSize',14,'Position',[0.11 0.85 0.1 0.05],'Visible','on');
P6=uicontrol('Parent',hFig,'Style','checkbox','String', 'Gray Scale','Units','normalized','FontSize',14,'Position',[0.21 0.95 0.1 0.05],'Visible','on');


function brws(src,event)
a=uigetfile('.jpg');
assignin('base','a',a);
b=imread(a);

imshow(b);

end
function rs(src,event)
a=evalin('base','a');
b=imread(a);
imshow(b);
system('taskkill /F /IM EXCEL.EXE');
delete 'results.xlsx';
c2=evalin('base','P2');
c3=evalin('base','P3');
c4=evalin('base','P4');
c5=evalin('base','P5');
c6=evalin('base','P6');
c2.Value=0;
c3.Value=0;
c4.Value=0;
c5.Value=0;
c6.Value=0;
end
function ws(src,event)

a=evalin('base','a');
b=imread(a);
c=evalin('base','P1');
switch c.Value
    case 1
    z=b;
    case 2
    [z]=selectarea(b);
    case 3
    [z]=selectpoint(b);
    case 4
    [z]=selectellipse(b);
    case 5
    [z]=selectrectangle(b);    
end
imshow(z);
assignin('base','z',z);
end
function sv(src,event)
system('taskkill /F /IM EXCEL.EXE');
a=evalin('base','a');
b=imread(a);
c2=evalin('base','P2');
c3=evalin('base','P3');
c4=evalin('base','P4');
c5=evalin('base','P5');
c6=evalin('base','P6');
z=evalin('base','z');
    if c2.Value==1
    z2=z;
    else
        z2=[];
    end
    if c3.Value==1
    z3=rgb2ntsc(z);
        else
        z3=[];
    end
    if c4.Value==1
    z4=rgb2hsv(z);
        else
        z4=[];
    end
    if c5.Value==1
    z5=rgb2ycbcr(z);
        else
        z5=[];
    end
    if c6.Value==1
    z6=rgb2gray(z);
        else
        z6=[];
    end


sheet=0;
if isempty(z2)==0
    z=z2;
if size(z,3)==3
sav=z;
name={'R','G','B'};
sheet=sheet+1;
end
if size(z,3)==1
        msgbox('The picture has not any color. The gray scale image will be saved.');
    sav=z;
    name={'Gray Image'};
    sheet=sheet+1;
end

sheet=exportres(sav,sheet,name);
end


if isempty(z3)==0
    z=z3;
if size(z,3)==3
sav=z;
sheet=sheet+1;
name={'Y','I','Q'};
end
if size(z,3)==1

        msgbox('The picture has not any color. The gray scale image will be saved.');

    sav=z;
    sheet=sheet+1;
    name={'Gray Image'};    
end
sheet=exportres(sav,sheet,name);
end

if isempty(z4)==0
    z=z4;
if size(z,3)==3
sav=z;
sheet=sheet+1;
name={'H','S','V'};
end
if size(z,3)==1

        msgbox('The picture has not any color. The gray scale image will be saved.');

    sav=z;
    sheet=sheet+1;
    name={'Gray Image'};    
end

sheet=exportres(sav,sheet,name);
end

if isempty(z5)==0
    z=z5;
if size(z,3)==3
sav=z;
sheet=sheet+1;
name={'Y','Cb','Cr'};
end
if size(z,3)==1

        msgbox('The picture has not any color. The gray scale image will be saved.');

    sav=z;
    sheet=sheet+1;
    name={'Gray Image'};    
end
sheet=exportres(sav,sheet,name);
end

if isempty(z6)==0
    z=z6;

sav=z;
sheet=sheet+1;
name={'Gray Image'}; 

sheet=exportres(sav,sheet,name)
end
winopen('results.xlsx');
end
