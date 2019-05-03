function [result,Index,RequiredPosition]=isSolutionAailable(Seq,AssemblyData)

% while ~isempty(AssemblyData)    
    LenOfSeq=length(Seq);
    for LOS=1:LenOfSeq
        TaskIndex=[AssemblyData.Task]==Seq(LOS);
        if ~isequal(AssemblyData(TaskIndex).Predecessor,0)&&~isempty(AssemblyData(TaskIndex).Predecessor)
            result=false;
            Index=LOS;
            RequiredPosition=AssemblyData(TaskIndex).Predecessor;
            return;
        else
            TempSuccessor=AssemblyData(TaskIndex).Successor;
            if ~isequal(TempSuccessor,0)
                for j=TempSuccessor
                    TaskIndex=[AssemblyData.Task]==j;
                    if length(AssemblyData(TaskIndex).Predecessor)==1
                        AssemblyData(TaskIndex).Predecessor(AssemblyData(TaskIndex).Predecessor==Seq(LOS))=0;
                    else
                        AssemblyData(TaskIndex).Predecessor(AssemblyData(TaskIndex).Predecessor==Seq(LOS))=[];
                    end
                end
            end
            TaskIndex=[AssemblyData.Task]==Seq(LOS);
            AssemblyData(TaskIndex)=[];
        end
    end
% end
result=true;
Index=0;
RequiredPosition=0;
return;         