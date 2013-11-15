%
% Command line user interface
%

queryPath = '';
TRUE = 1;
FALSE = 0;
databaseConstructed = TRUE;
rgbHiss = zeros(216, 2, 1000);

fid = fopen('D:\MART\Image Database\Feature Base.bin');
if fid == -1
    disp('Image database does not exist in D:\MART\Image Database.');
    choice = lower(input('Do you want to construct it now? (Y/N): ', 's'));
    if strcmp(choice, 'y') == TRUE
        databaseConstruction();
        fid = fopen('D:\MART\Image Database\Feature Base.bin');
    else
        databaseConstructed = FALSE;
    end
end

if databaseConstructed == TRUE
    for i = 1 : 1000
        rgbHiss(:, :, i) = fread(fid, [216, 2], 'double');
    end
    fclose(fid);

    if isempty(dir('D:\MART\Setings')) == TRUE
        mkdir('D:\MART\Setings');
    end
    
    fid_seting = fopen('D:\MART\Setings\Setings.txt');
    if fid_seting == -1
        fid_seting = fopen('D:\MART\Setings\Setings.txt', 'w+');
    end
    setingData = textscan(fid_seting, '%s', 'delimiter', '$');
    setingData = setingData{1}{1};
    [queryPath, setingData] = strtok(setingData, '$');
    fclose(fid_seting);
    
    disp(sprintf(strcat('Welcome to our image searching engine.\n',...
        'You can begin searching using commands or you may want to enter HELP to see the available commands.')));
    
    cmd = lower(input('$ ', 's'));
end

while strcmp(cmd, 'exit') == FALSE && databaseConstructed == TRUE
    switch cmd
        case 'search'
            rank = queryDatabase(queryPath, rgbHiss);
            tmp = 0;
            for i = tmp + 1 : tmp + 15
                subplot(3, 5, i - tmp), imshow(imread(['D:\MART\Images\', num2str(rank(i) - 1), '.jpg']),...
                    'Border', 'tight');
            end
            choice = lower(input('See the next 15 results? (Y/N): ', 's'));
            while strcmp(choice, 'y') == TRUE && i + 15 <= 1000
                tmp = tmp + 15;
                for i = tmp + 1 : tmp + 15
                    subplot(3, 5, i - tmp), imshow(imread(['D:\MART\Images\', num2str(rank(i) - 1), '.jpg']),...
                        'Border', 'tight');
                end
                choice = lower(input('See the next 15 results? (Y/N): ', 's'));
            end
        case 'experiment'
            base = str2double(input('Choose a base (a base is the index of the first image of each genre): ', 's'));
            while mod(base, 100) ~= 0 || base < 0 || base > 900
                disp('A base should be one of 0, 100, ..., 900.');
                base = str2double(input('Choose a base: ', 's'));
            end
            
            disp('Experiment is running...');
            [ma, sd, ac] = assess(base, queryPath, rgbHiss);
            disp(sprintf(['Experiment completes.\n',...
                'Statistical Summary:\n',...
                'Average Accuracy for Genre ', num2str(floor(base / 100)), 'is ', num2str(ma), '\n',...
                'Maximum Accuracy is ', num2str(max(ac)), '\n',...
                'Minimum Accuracy is ', num2str(min(ac)), '\n',...
                'Standard Deviation is ', num2str(sd)]));
        case 'help'
            disp(sprintf(strcat('Available commands:\n',...
                'Search - search for similar images as the queryed image from the database\n',...
                'Experiment - test the performance of the engine\n',...
                'DefaultPath - set the default path for queries\n',...
                'ResetDefaultPath - reset default path for queries to empty',...
                'Help - show help list\n',...
                'Exit - exit this program')));
        case 'defaultpath'
            if strcmp(queryPath, '') == TRUE
                disp('Default path for queries is not set.');
            else
                disp(['Current default path for queries is ', queryPath]);
            end

            queryPath = input('New Path: ', 's');
            if isempty(dir(queryPath)) == TRUE || isdir(queryPath) == FALSE
                disp('Invalid path detected! Default path is set to empty!');
                queryPath = '';
            else
                if strcmp(queryPath(length(queryPath)), '\') == FALSE
                    queryPath = strcat(queryPath, '\');
                end
                disp('Default path change succeeded.');
                disp(['Current default path for queries is ', queryPath]);
            end
        case 'resetdefaultpath'
            queryPath = '';
            disp('Default path for queries is reset to empty.');
        otherwise
            disp('Oops! Invalid command!');
    end
    
    cmd = lower(input('$ ', 's'));
end

fid_seting = fopen('D:\MART\Setings\Setings.txt', 'w');
fwrite(fid_seting, [queryPath, '$']);
fclose(fid_seting);

disp('God Speed!');