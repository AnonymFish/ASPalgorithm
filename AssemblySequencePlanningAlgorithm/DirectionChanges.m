function nChanges=DirectionChanges(Position,data)
% data is cell type in case that char data

nPosition=size(Position,2);
nChanges=0;

for j=2:nPosition
    if ~isequal(data{Position(j),1},data{Position(j-1),1})
        nChanges=nChanges+1;
    end
end