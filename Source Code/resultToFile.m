global imageFilePath;
imageFilePath = 'D:\MART\Images\';

set(resultFileButton,'Visible','off');
set(resultFileTips, 'Visible','on','String','wait a moment...');

fid = fopen('result.txt','w');

for base=0:9
    accuracies = getResultAccess(base*100, imageFilePath, rgbHiss);
    for index=1:100
        fprintf(fid,'%f\n',accuracies(index) );
    end
end

fclose(fid);

set(resultFileTips, 'Visible','on','String','result.txt file in current path','Position', [0.01 0.250 0.15 0.05]);