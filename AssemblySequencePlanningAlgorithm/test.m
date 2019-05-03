clear
clc
% read relative datas
% path='./WallAssembly.xlsx';
path='./TableVise.xlsx';
% path='./ToyTrain.xlsx';
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

TempAADN=1;
for AADN=1:length(AssemblyData)
    if isempty(AssemblyData(AADN).Predecessor)|| isequal(AssemblyData(AADN).Predecessor,0)
        AvailableAssemblyData(TempAADN,:)=AssemblyData(AADN);
        TempAADN=TempAADN+1;
    end
end
if length([AvailableAssemblyData.Task])==1
    MiniFitnessIndex=[AvailableAssemblyData.Task];
else
    MiniFitnessIndex=randsample([AvailableAssemblyData.Task],1);
end
Seq=[AssemblyData(MiniFitnessIndex).Task];
Recursions=0;

Data=AssemblyData;
[Seq,Recursions]=MinimumFitness(Seq,Recursions,Data,AssemblyData,ObjectiveType,MiniFitnessIndex);

Pop.Position=Seq;
Pop.Objective=[];
Pop.Recursions=Recursions;
Pop=ComputeObjectiveValue(Pop,ObjectiveType,Data);
Pop.Tool=[AssemblyData(Pop.Position).Tool];
Pop.Direction=[AssemblyData(Pop.Position).Direction];

PriorityLevel=0;
TempAssemblyData=AssemblyData;
AssemblyData=PriorityDetermination(AssemblyData,TempAssemblyData,PriorityLevel);

% Pop=BlockPrecedence(Pop,AssemblyData);

Example.Position=[4,9,6,12,11,5,3,7,8,17,13,14,1,19,16,10,18,15,2];
Example.Objective=[];
Example=ComputeObjectiveValue(Example,ObjectiveType,Data);
Example.Tool=[AssemblyData(Example.Position).Tool];
Example.Direction=[AssemblyData(Example.Position).Direction];

Pop=AdjustingFeasibility(Pop,AssemblyData);