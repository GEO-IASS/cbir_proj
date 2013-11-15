%请保存文件名字为：open_menu_1.m
%[filename pathname]=uigetfile({'*.bmp','BMP图象(*.bmp)';...
%    '*.jpg','JPG图象(*.jpg)';'*.gif','GIF图象(*.gif)';...
%    '*.tif','TIF图象(*.tif)';'*.png','PNG图象(*.png)';...
%    '*.*','ALL FILES(*.*)'},'Choose an image.');

global chosenImageName;
global im111;
global filename;

[filename pathname]=uigetfile( ...
         {'*.jpg'; '*.bmp'; '*.gif'; '*.tif'; '*.png'; '*.*'},...
         'Choose an image.',pathname);

if isequal([filename pathname],[0,0])
    return;
end

chosenImageName = [pathname filename];
im111 = imread(chosenImageName);
img11 = double(im111)/256;

%set(chosenImg, 'UserData', str);
set(chosenImg, 'CData', img11);

set(buttonRun,'Visible','on');
set(buttonNext,'Visible','off');
set(buttonPrev,'Visible','off');
set(result, 'Visible','off');
set(chosenImg,'Visible','on');

openAgain = openAgain + 1;

%get the result images array
%get the result accuracy rate
%global imgList;
%imgList = randint(1, 100, [0,999]);
%global rate;
%rate = rand(1, 1);
%rate = round(rate*1000)/1000;
