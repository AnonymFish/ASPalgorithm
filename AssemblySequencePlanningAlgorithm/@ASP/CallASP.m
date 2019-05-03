function CallASP(obj,ObjectiveType,data)

obj.Initialization(ObjectiveType,data);

for i=1:obj.nIter
    if obj.nPosition==size(obj.Pop(1).Position,2)
        break;
    else
        obj.EvolutionProcess(ObjectiveType,data);
    end
end