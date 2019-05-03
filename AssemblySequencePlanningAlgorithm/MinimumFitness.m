function [Seq,Recursions]=MinimumFitness(Seq,Recursions,Data,AssemblyData,ObjectiveType,MiniFitnessIndex)
% Seq=[Seq,AssemblyData(MiniFitnessIndex).Task];
if isempty(Recursions)||isequal(Recursions,0)
    RecursionTime=1;
else
    RecursionTime=Recursions(end)+1;
end
TempAssemblyData=AssemblyData;
LenOfSeq=length(AssemblyData);
if LenOfSeq~=0
    if LenOfSeq==0
        return;
    else
        TempTask=AssemblyData(MiniFitnessIndex).Task;
        TempSuccessor=AssemblyData(MiniFitnessIndex).Successor;
        if ~isequal(TempSuccessor,0)
            for j=TempSuccessor
                TaskIndex=[TempAssemblyData.Task]==j;
                if length(TempAssemblyData(TaskIndex).Predecessor)==1
                    TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==AssemblyData(MiniFitnessIndex).Task)=0;
                else
                    TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==AssemblyData(MiniFitnessIndex).Task)=[];
                end
            end
        end
        TempAssemblyData([TempAssemblyData.Task]==TempTask)=[];

        for Si=1:LenOfSeq
            if Si~=MiniFitnessIndex
                if isequal(AssemblyData(Si).Direction,AssemblyData(MiniFitnessIndex).Direction)...
                        && isequal(AssemblyData(Si).Tool,AssemblyData(MiniFitnessIndex).Tool)
                    Seq=[Seq,AssemblyData(Si).Task];
                    result=isSolutionAailable(Seq,Data);
                    if result==1
                        Recursions=[Recursions,RecursionTime];
                        
                        TempSuccessor=AssemblyData(Si).Successor;
                        if ~isequal(TempSuccessor,0)
                            for j=TempSuccessor
                                TaskIndex=[TempAssemblyData.Task]==j;
                                if length(TempAssemblyData(TaskIndex).Predecessor)==1
                                    TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==AssemblyData(Si).Task)=0;
                                else
                                    TempAssemblyData(TaskIndex).Predecessor(TempAssemblyData(TaskIndex).Predecessor==AssemblyData(Si).Task)=[];
                                end
                            end
                        end
                        
                        TempAssemblyData([TempAssemblyData.Task]==AssemblyData(Si).Task)=[];
                    else
                        Seq(end)=[];
                    end
                end
            end
        end
        
        LenOfSeq=length(TempAssemblyData);
        if LenOfSeq~=0
%             Pop.Position=Seq(end);
%             Pop.Objective=[];
            for Si=1:LenOfSeq
                Pop.Position=[Seq,TempAssemblyData(Si).Task];
                Pop.Objective=[];
                Pop=ComputeObjectiveValue(Pop,ObjectiveType,Data);
                %             Pop.Direction=[AssemblyData(Pop.Position).Direction];
                %             Pop.Tool=[AssemblyData(Pop.Position).Tool];
                FitnessChanged(Si)=Pop.Objective(3);
            end
            
            result=0;
            while ~result               
                [MinFitness,~]=min(FitnessChanged);
                AllMiniFitnessIndex=find(FitnessChanged==MinFitness);
%                 AllMiniFitnessIndex=FitnessChanged;
                if any([TempAssemblyData(AllMiniFitnessIndex).Predecessor]==0)
                    if length(AllMiniFitnessIndex)==1
                         MiniFitnessIndex=AllMiniFitnessIndex;
                    else
                    MiniFitnessIndex=randsample(AllMiniFitnessIndex,1);
                    end
                    Seq=[Seq,TempAssemblyData(MiniFitnessIndex).Task];
                    result=isSolutionAailable(Seq,Data);
                    while ~result
                        Seq(end)=[];
                        if length(AllMiniFitnessIndex)==1
                            MiniFitnessIndex=AllMiniFitnessIndex;
                        else
                            MiniFitnessIndex=randsample(AllMiniFitnessIndex,1);
                        end
                        Seq=[Seq,TempAssemblyData(MiniFitnessIndex).Task];
                        result=isSolutionAailable(Seq,Data);
                    end
                    
                else
                    FitnessChanged(FitnessChanged==MinFitness)=Inf;
                end
            end
            Recursions=[Recursions,RecursionTime];
            [Seq,Recursions]=MinimumFitness(Seq,Recursions,Data,TempAssemblyData,ObjectiveType,MiniFitnessIndex);
        end
    end
end