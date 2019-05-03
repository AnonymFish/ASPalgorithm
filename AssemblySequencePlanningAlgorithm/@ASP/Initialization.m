% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP function:initialization

function Initialization(obj,type,data)

%% Parameter setting
nPop=obj.nPop;
Pop=obj.Pop;
PopData=obj.PopData;

EmptyTask.Task=0;
EmptyTask.Predecessor=0;
EmptyTask.Successor=0;
EmptyTask.Direction=0;
EmptyTask.Tool=0;

% Define the size of the initial task,we choose two tasks
Task=zeros(nPop,2);

%% Select two available task from asp problem for each individual
for i=1:nPop
    
    % Allocate storage space for initial available task, and choose available task randomly from availabe space, 
    StartTask=repmat(EmptyTask,obj.nPosition,1);
    TempI=1;
    for j=1:length(data)
        % If one task has no Predecessor, then it can be the initial task
        if isempty(data(j).Predecessor) || isequal(data(j).Predecessor,0)
            StartTask(TempI,:)=data(j);
            TempI=TempI+1;
        end
    end
    % All availabe initial tasks
    LengthOfStartPredecessor=size(StartTask(([StartTask.Task]~=0),:),1);
    
    % Give each pop a data that used to compute the sequence after, when a task
    % is chosen, then the relative information of this task will be clear
    % Construct a Subdata for each pop
    TempName=['PopData',num2str(i)];
    PopData.(TempName)=data;
    % 2 is because we choose two tasks at first
    for k=1:2
        % Choose one task randomly
        Task(i,k)=StartTask(randsample(1:LengthOfStartPredecessor,1)).Task;
        % Clear its relative information, first clear it from the
        % predecessor of its next task
        TaskIndex=[PopData.(TempName).Task]==Task(i,k);
        TempSuccessor=PopData.(TempName)(TaskIndex).Successor;
        if TempSuccessor~=0
            for j=TempSuccessor
                TaskIndex=[PopData.(TempName).Task]==j;
                if length(PopData.(TempName)(TaskIndex).Predecessor)==1
                    PopData.(TempName)(TaskIndex).Predecessor(PopData.(TempName)(TaskIndex).Predecessor==Task(i,k))=0;
                else
                    PopData.(TempName)(TaskIndex).Predecessor(PopData.(TempName)(TaskIndex).Predecessor==Task(i,k))=[];
                end
            end
        end
        % then clear the chosen task
        TaskIndex=[PopData.(TempName).Task]==Task(i,k);
        PopData.(TempName)(TaskIndex)=[];
        
        % Choose another initial tasks, it is different for each time
        StartTask=repmat(EmptyTask,obj.nPosition,1);
        TempI=1;
        for j=1:length(PopData.(TempName))
            if isempty(PopData.(TempName)(j).Predecessor)||isequal(PopData.(TempName)(j).Predecessor,0)
                StartTask(TempI,:)=PopData.(TempName)(j);
                TempI=TempI+1;
            end
        end
        LengthOfStartPredecessor=size(StartTask(([StartTask.Task]~=0),:),1);
    end
    Pop(i,:).Position=Task(i,:);
end

% Compute Objective
Pop=ComputeObjectiveValue(Pop,type,data);

% Return
obj.Pop=Pop;
obj.PopData=PopData;