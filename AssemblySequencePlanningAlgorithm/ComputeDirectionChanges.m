function Pop=ComputeDirectionChanges(Pop,data)
% data is cell type in case that char data

nPop=size(Pop,1);
nPosition=size(Pop(1).Position,2);
nChanges=0;

for i=1:nPop
    for j=2:nPosition
        if ~isequal(data{Pop(i).Position(j),1},data{Pop(i).Position(j-1),1})
            nChanges=nChanges+1;
        end
    end
    Pop(i).Objective(1,:)=nChanges;
    nChanges=0;
end