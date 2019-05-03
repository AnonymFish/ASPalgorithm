function Pop=BlockPrecedence(Pop,AssemblyData)

RecursionTimes=unique(Pop.Recursions);
AssemblyData=AssemblyData(Pop.Position);
for RT=RecursionTimes
    BlockPositionIndex=Pop.Recursions==RT;
    BlockPosition=Pop.Position(BlockPositionIndex);
    PriorityOfBlockPosition=[AssemblyData(BlockPositionIndex).PriorityLevel];
    [PriorityOfBlockPosition,PriorityOfBlockPositionIndex]=sort(PriorityOfBlockPosition,'ascend');
    Pop.Position(BlockPositionIndex)=BlockPosition(PriorityOfBlockPositionIndex);
end


