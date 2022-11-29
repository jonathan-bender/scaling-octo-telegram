
function analyzeProfilometerData(sourcePath, range)

% smoothing
SMOOTHING = 35;

% read data
opts = delimitedTextImportOptions('NumVariables', 5);
opts.DataLines = [2, Inf];
opts.Delimiter = '\t';
opts.VariableNames = {'Counter', 'Altitudem', 'Encoder1m', 'Encoder2m', 'RowNumber'};
opts.VariableTypes = {'double', 'double', 'double', 'double', 'double'};
opts.ExtraColumnsRule = 'ignore';
opts.EmptyLineRule = 'read';
tableData = readtable([sourcePath '.txt'], opts);
data = table2array(tableData);

% read parameters file
paramOpts = delimitedTextImportOptions('NumVariables', 2);
paramOpts.DataLines = [3, Inf];
paramOpts.Delimiter = '=';
paramOpts.VariableNames = {'Frequency', 'Hz'};
paramOpts.VariableTypes = {'double', 'double'};
paramOpts.ExtraColumnsRule = 'ignore';
paramOpts.EmptyLineRule = 'read';
paramOpts = setvaropts(paramOpts, {'Frequency', 'Hz'}, 'TrimNonNumeric', true);
paramOpts = setvaropts(paramOpts, {'Frequency', 'Hz'}, 'ThousandsSeparator', ',');
tableParameters = readtable([sourcePath '_parameters.txt'], paramOpts);
parameters = table2array(tableParameters);

% read parameters
xScale = parameters(2,2);

columnCount = size(data,1);
read = -data(:,2);

if size(range,2) > 1
    roundedRange = round((range(1):range(2))/xScale);
    read = read(roundedRange);
end

% fix slope
linearParams = polyfit(1:columnCount, read, 1);
read = read - polyval(linearParams, 1:columnCount);

% smooth
smoothed = smooth(read, SMOOTHING);
roughness = abs(read - smoothed);
avgRoughness = 2 * prctlie(roughness, 98);
stdRoughness = std(roughness);

disp(['Average Roughness: ', num2str(avgRoughness), ' microns. Standard Deviation: ', num2str(stdRoughness)]);

totalWidth = xScale * columnCount;
widthAxis = linspace(0, totalWidth, columnCount);
plot(widthAxis, read);
xlabel([num2str(totalWidth) ' mm']);
ylabel('Height (microns)');
title(['Profile' num2str(midRow)]);

end