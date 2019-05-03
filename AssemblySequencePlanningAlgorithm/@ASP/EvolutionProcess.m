% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP function:evolution process

function EvolutionProcess(obj,type,data)

%% Parameter setting
Pop=obj.Pop;
nPop=obj.nPop;
nSparks=obj.nSparks;
PopData=obj.PopData;
nPosition=size(Pop(1).Position,2);
% Define the space of tasks for this generation
Task=zeros(nSparks*nPop,nPosition+1);
EmptyPop.Position=[];
EmptyPop.Objective=[];
EmptyPop.isRepeated=0;
% Because of explosion, so we set a temp pop to store all solutions and
% then select nPop most best ones
TempPop=repmat(EmptyPop,nSparks*nPop,1);
EmptyTask.Task=0;
EmptyTask.Predecessor=0;
EmptyTask.Successor=0;
EmptyTask.Direction=0;
EmptyTask.Tool=0;

%% Main process
for i=1:nPop
    PopDataName=['PopData',num2str(i)];
    % one individual will have some sparks when it is exploded
    for n=1:nSparks
        % Copy current position sequence
        Task(nSparks*(i-1)+n,1:nPosition)=Pop(i).Position;
        % each individual need one data
        SubPopDataName=['SubPopData',num2str(nSparks*(i-1)+n)];
        SubPopData.(SubPopDataName)=PopData.(PopDataName);
        
        % Allocate storage space for initial available task, and choose available task randomly from availabe space,
        StartTask=repmat(EmptyTask,obj.nPosition,1);
        TempI=1;
        % Get available initial tasks 
        for j=1:length(SubPopData.(SubPopDataName))
            % If one task has no Predecessor, then it can be the initial task
            if isequal(SubPopData.(SubPopDataName)(j).Predecessor,0)||isempty(SubPopData.(SubPopDataName)(j).Predecessor)
                StartTask(TempI,:)=SubPopData.(SubPopDataName)(j);
                TempI=TempI+1;
            end
        end
        % Choose one task randomly
        LengthOfStartPredecessor=size(StartTask(([StartTask.Task]~=0),:),1);
        Task(nSparks*(i-1)+n,nPosition+1)=StartTask(randsample(1:LengthOfStartPredecessor,1)).Task;
        
        % Clear its relative information, first clear it from the
        % predecessor of its next task, then clear the chosen task
        TaskIndex=[SubPopData.(SubPopDataName).Task]==Task(nSparks*(i-1)+n,nPosition+1);
        TempSuccessor=SubPopData.(SubPopDataName)(TaskIndex).Successor;
        if TempSuccessor~=0
            for j=TempSuccessor
                TaskIndex=[SubPopData.(SubPopDataName).Task]==j;
                if length(SubPopData.(SubPopDataName)(TaskIndex).Predecessor)==1
                    SubPopData.(SubPopDataName)(TaskIndex).Predecessor(SubPopData.(SubPopDataName)(TaskIndex).Predecessor==Task(nSparks*(i-1)+n,nPosition+1))=0;
                else
                    SubPopData.(SubPopDataName)(TaskIndex).Predecessor(SubPopData.(SubPopDataName)(TaskIndex).Predecessor==Task(nSparks*(i-1)+n,nPosition+1))=[];
                end
            end
        end
        TaskIndex=[SubPopData.(SubPopDataName).Task]==Task(nSparks*(i-1)+n,nPosition+1);
        SubPopData.(SubPopDataName)(TaskIndex)=[];
        TempPop(nSparks*(i-1)+n,:).Position=Task(nSparks*(i-1)+n,:);
        for c=1:nSparks*(i-1)+n-1
            if TempPop(nSparks*(i-1)+n).Position==TempPop(nSparks*(i-1)+n-c).Position
                TempPop(nSparks*(i-1)+n).isRepeated=TempPop(nSparks*(i-1)+n-c).isRepeated+1;
                break
            end
        end
    end
end
% Put all pop together and decide which one is good, good ones will become
% next population
% Return
[obj.Pop,obj.PopData]=obj.SelectNextPop(TempPop,nPop,SubPopData,type,data);

