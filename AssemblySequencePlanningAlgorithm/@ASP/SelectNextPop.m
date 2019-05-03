% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP function:Select next population

function [Pop,PopData]=SelectNextPop(TempPop,nPop,SubPopData,type,data)

empty_individual=TempPop(1);
PopName=fieldnames(empty_individual);
for i=1:length(PopName)
    empty_individual=setfield(empty_individual,char(PopName(i)),[]);
end

Pop=repmat(empty_individual,nPop,1);
% Put all pop together and decide which one is good, good ones will become
% next population
TempPop=ComputeObjectiveValue(TempPop,type,data);
TempObj=[TempPop.Objective];
TempObj=TempObj(3,:);
[~,ObjIndex]=sort(TempObj,'ascend');
TempPop=TempPop(ObjIndex);

% Seek solution not repetitve,and if it has to have repetitive solutions,
% only one repetitive for one solution at one time, then two repetitives
% then three repetitives....
% This is an iteration function
[Pop,PopData]=SeekSolution(nPop,Pop,SubPopData,TempPop,ObjIndex);