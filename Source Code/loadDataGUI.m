function rgbHiss = loadDataGUI(filePath)

rgbHiss = zeros(216, 2, 1000);

fid = fopen([filePath, '\Feature Base.bin']);
for i = 1 : 1000
    rgbHiss(:, :, i) = fread(fid, [216, 2], 'double');
end
fclose(fid);