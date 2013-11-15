global displayImages;

global imageFilePath;
imageFilePath = 'D:\MART\Images\';

if page==0 && openAgain==1
    page = page + 1;
    for r = 1:25
        displayImages(r) = image(...
                'Interruptible','on',...
                'Parent', imagesAxeses(r)...
        );
        im111 = imread( strcat( imageFilePath, num2str(imgList(r)-1), '.jpg') );
        img11 = double(im111)/256;
        set(displayImages(r), 'CData', img11);
    end
elseif page<4
        page = page + 1;
        for k = 1:25
            im222 = imread( strcat( imageFilePath, num2str(imgList(k+(page-1)*25)-1), '.jpg') );
            img22 = double(im222)/256;
            set(displayImages(k),'CData',img22);
        end
end

if page>1
    set(buttonPrev,'Visible','on');
end

if page==4
    set(buttonNext,'Visible','off');
end