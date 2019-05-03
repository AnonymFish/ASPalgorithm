function Pop=ASPObjectiveValue(Pop,data)
nPop=size(Pop,1);
% Get direction data and tool data
DirectionData=cell(length(data),1);
ToolData=cell(length(data),1);
for i=1:length(data)
    DirectionData(i,:)={data(i).Direction};
    ToolData(i,:)={data(i).Tool};
end

% Compute changes
Pop=ComputeDirectionChanges(Pop,DirectionData);
Pop=ComputeToolChanges(Pop,ToolData);
for i=1:nPop
Pop(i).Objective(3,:)=Pop(i).Objective(1,:)+Pop(i).Objective(2,:);
end
