function AssemblyData=PriorityDetermination(AssemblyData,TempAssemblyData,PriorityLevel)
if ~isempty(TempAssemblyData)
    if isempty(PriorityLevel) || isequal(PriorityLevel,0)
        PriorityLevel=1;
    else
        PriorityLevel=PriorityLevel+1;
    end
    TempI=1;
    % Get available initial tasks
    for j=1:length(TempAssemblyData)
        % If one task has no Predecessor, then it can be the initial task
        if isempty(TempAssemblyData(j).Predecessor)||isequal(TempAssemblyData(j).Predecessor,0)
            AssemblyData([AssemblyData.Task]==TempAssemblyData(j).Task).PriorityLevel=PriorityLevel;
            StartTask(TempI,:)=TempAssemblyData(j);
            TempI=TempI+1;
        end
    end
    % Choose one task randomly
    LengthOfStartPredecessor=size(StartTask(([StartTask.Task]~=0),:),1);
    if LengthOfStartPredecessor~=0
        for Task=[StartTask.Task];
            % Clear its relative information, first clear it from the
            % predecessor of its next task, then clear the chosen task
            TaskIndex=[TempAssemblyData.Task]==Task;
            TempSuccessor=TempAssemblyData(TaskIndex).Successor;
            if ~isequal(TempSuccessor,0)
                for j=TempSuccessor
                    TaskIndex=[TempAssemblyData.Task]==j;
                    %                 if all(TaskIndex==0)
                    %                     pause();
                    %                 end
                    if length(TempAssemblyData(TaskIndex).Predecessor)==1
                        TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==Task)=0;
                    else
                        TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==Task)=[];
                    end
                end
            end
            TaskIndex=[TempAssemblyData.Task]==Task;
            TempAssemblyData(TaskIndex)=[];
        end
    end
    AssemblyData=PriorityDetermination(AssemblyData,TempAssemblyData,PriorityLevel);
end