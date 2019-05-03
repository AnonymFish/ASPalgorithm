function Pop=AdjustingFeasibility(Pop,AssemblyData)

LenOfSeq=length(Pop.Position);
isFeasible=0;
while ~isFeasible
    [result,Index,RequiredPosition]=isSolutionAailable(Pop.Position,AssemblyData);
    if result~=1
%         RequiredPosition=AssemblyData(Pop.Position(Index)).Predecessor;
        for RP=RequiredPosition
%             PositionIndex=find(Pop.Position==RP);
%             Recursions=Pop.Recursions(PositionIndex);
%             PositionIndexOfRecursion=find(Pop.Recursions==Recursions,1);
%             PositionIndex=min(PositionIndex,PositionIndexOfRecursion);
%             TempPosSlice=Pop.Position(PositionIndex:end);
%             TempRecursionsSlice=Pop.Recursions(PositionIndex:end);
%             TempPosSlice1=TempPosSlice(TempRecursionsSlice==Recursions);
%             TempPosSlice2=TempPosSlice(TempRecursionsSlice~=Recursions);
%             TempRecSlice1=TempRecursionsSlice(TempRecursionsSlice==Recursions);
%             TempRecSlice2=TempRecursionsSlice(TempRecursionsSlice~=Recursions);
%             
%             NewPosition=Pop.Position(1:Index-1);
%             NewPosition=[NewPosition,TempPosSlice1];
%             NewPosition=[NewPosition,Pop.Position(Index:PositionIndex-1)];
%             NewPosition=[NewPosition,TempPosSlice2];
%             Pop.Position=NewPosition;
%             
%             NewRecursions=Pop.Recursions(1:Index-1);
%             NewRecursions=[NewRecursions,TempRecSlice1];
%             NewRecursions=[NewRecursions,Pop.Recursions(Index:PositionIndex-1)];
%             NewRecursions=[NewRecursions,TempRecSlice2];
%             Pop.Recursions=NewRecursions;
%             Pop=ComputeObjectiveValue(Pop,'asp',AssemblyData);
%             Pop.Tool=[AssemblyData(Pop.Position).Tool];
%             Pop.Direction=[AssemblyData(Pop.Position).Direction];

            PositionIndex=find(Pop.Position==RP);
            Recursions=Pop.Recursions(PositionIndex);
            PositionIndexOfRecursion=PositionIndex-1;
            while Pop.Recursions(PositionIndex)==Pop.Recursions(PositionIndexOfRecursion)
                PositionIndexOfRecursion=PositionIndexOfRecursion-1;
            end
            PositionIndexOfRecursion=PositionIndexOfRecursion+1;
            PositionIndex=min(PositionIndex,PositionIndexOfRecursion);
            TempPosSlice=Pop.Position(PositionIndex:end);
            TempRecursionsSlice=Pop.Recursions(PositionIndex:end);
%             TempPosSlice1=TempPosSlice(TempRecursionsSlice==Recursions);
%             TempPosSlice2=TempPosSlice(TempRecursionsSlice~=Recursions);
%             TempRecSlice1=TempRecursionsSlice(TempRecursionsSlice==Recursions);
%             TempRecSlice2=TempRecursionsSlice(TempRecursionsSlice~=Recursions);
            
            NewPosition=Pop.Position(1:Index-1);
            NewPosition=[NewPosition,TempPosSlice];
            NewPosition=[NewPosition,Pop.Position(Index:PositionIndex-1)];
%             NewPosition=[NewPosition,TempPosSlice2];
            Pop.Position=NewPosition;
            
            NewRecursions=Pop.Recursions(1:Index-1);
            NewRecursions=[NewRecursions,TempRecursionsSlice];
            NewRecursions=[NewRecursions,Pop.Recursions(Index:PositionIndex-1)];
%             NewRecursions=[NewRecursions,TempRecSlice2];
            Pop.Recursions=NewRecursions;
            Pop=ComputeObjectiveValue(Pop,'asp',AssemblyData);
            Pop.Tool=[AssemblyData(Pop.Position).Tool];
            Pop.Direction=[AssemblyData(Pop.Position).Direction];
        end
    else
        isFeasible=1;
    end
end
Pop=ComputeObjectiveValue(Pop,'asp',AssemblyData);
Pop.Tool=[AssemblyData(Pop.Position).Tool];
Pop.Direction=[AssemblyData(Pop.Position).Direction];