%% Get datas
% clear workspace
clear
%% for population size and spark size
PopSize=[10 20 30 40 50 60 70 80 90 100];
SparkSize=[10 20 30 40 50 60 70 80 90 100];

% read relative datas
%     path='./TableVise.xlsx';
path='./ToyTrain.xlsx';
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
for k=1:10
    %% Run 20 times
    for j=1:20
        tic
        %% Parameter setting
        ObjectiveType='asp';
        para.PopSize=PopSize(5);
        para.SparkSize=SparkSize(k);
        para.PositionSize=size(AssemblyData,1);
        ObjOfASP=ASP(para);
        ObjOfASP.CallASP(ObjectiveType,AssemblyData);
        toc
        objmin(k,j)=ObjOfASP.Pop(1).Objective(3,:);
        t(k,j)=toc;
    end
end
boxplot(objmin','Whisker',4)