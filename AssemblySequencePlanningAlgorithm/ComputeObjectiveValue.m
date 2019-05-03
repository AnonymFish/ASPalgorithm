% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson
% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function:compute relative objective value

function Pop=ComputeObjectiveValue(Pop,type,data)

if isequal(type,'ASM')|| isequal(type,'Assembly')|| isequal(type,'asm')
    % Call Assembly Objective function
    Pop=AssemblyObjectiveValue(Pop,data);
elseif isequal(type,'TSP')|| isequal(type,'tsp')
    % Call TSP function
    Pop=TSPObjectiveValue(Pop,data);
elseif isequal(type,'ASP')|| isequal(type,'asp')
    % Call ASP function
    Pop=ASPObjectiveValue(Pop,data);
end