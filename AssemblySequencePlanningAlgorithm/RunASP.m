%% Get datas
% clear workspace
clear
clc
% read relative datas
% path='./WallAssembly.xlsx';
% path='./TableVise.xlsx';
path='./ToyTrain.xlsx';
% path='./Expander.xlsx';
% path='./CompressionRoller.xlsx';
PrecedenceGraph=readtable(path,'Sheet','PrecedenceGraph');
Directions=readtable(path,'Sheet','Direction');
Tools=readtable(path,'Sheet','Tool');
AssemblyData=[PrecedenceGraph Directions Tools];

% turn table type to struct type
VariableNames=AssemblyData.Properties.VariableNames;
LengthOfVariableNames=size(VariableNames,2);
for i=1:LengthOfVariableNames
    if (iscell(AssemblyData.(VariableNames{i})) && isequal(VariableNames{i},'Successor')) || (iscell(AssemblyData.(VariableNames{i})) && isequal(VariableNames{i},'Predecessor'))
        if ischar(AssemblyData.(VariableNames{i}){1})
            for j=1:length(AssemblyData.Task)
                % turn cell type to num type
                % str2double can not work if there is vector in table
                AssemblyData.(VariableNames{i}){j}=str2num(AssemblyData.(VariableNames{i}){j});
            end
        end
    end
end
AssemblyData=table2struct(AssemblyData);
tic
%% Parameter setting
ObjectiveType='asp';
para.PopSize=100;
para.SparkSize=5;
para.PositionSize=size(AssemblyData,1);
ObjOfASP=ASP(para);
ObjOfASP.CallASP(ObjectiveType,AssemblyData);
toc