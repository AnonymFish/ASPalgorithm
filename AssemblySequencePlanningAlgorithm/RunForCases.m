%% Get datas
% clear workspace
clc
clear
%% for 3 cases
for k=1:3
    % read relative datas
    if k==1
        path='./WallAssembly.xlsx';
    elseif k==2
        path='./TableVise.xlsx';
    elseif k==3
        path='./ToyTrain.xlsx';
    end
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
    
    %% Run 20 times
    for j=1:20
        tic
        %% Parameter setting
        ObjectiveType='asp';
        para.PopSize=20;
        para.PositionSize=size(AssemblyData,1);
        ObjOfASP=ASP(para);
        ObjOfASP.CallASP(ObjectiveType,AssemblyData);
        toc
        objmin((k-1)*20+j,:)=ObjOfASP.Pop(1).Objective;
        objmax((k-1)*20+j,:)=ObjOfASP.Pop(1).Objective;
        t(k,j)=toc;
    end
end