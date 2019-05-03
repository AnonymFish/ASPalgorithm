% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP function:Seek Solutions

function [Pop,PopData]=SeekSolution(nPop,Pop,SubPopData,TempPop,ObjIndex)

% Seek solution not repetitve,and if it has to have repetitive solutions,
% only one repetitive for one solution at one time, then two repetitives
% then three repetitives....
% UsableNum=0;
nP=0;
for j=0:1:max([TempPop.isRepeated])
    UsableIndex=find([TempPop.isRepeated]==j);
    UsableNum=length(UsableIndex);
    
    if UsableNum+nP<=nPop
        for i=1:UsableNum
            PopDataName=['PopData',num2str(nP+i)];
            SubPopDataName=['SubPopData',num2str(ObjIndex(UsableIndex(i)))];
            Pop(nP+i)=TempPop(UsableIndex(i));
            PopData.(PopDataName)=SubPopData.(SubPopDataName);
            ObjIndex(UsableIndex(i))=0;
        end
        nP=nP+UsableNum;
    else
        for i=1:nPop-nP
            PopDataName=['PopData',num2str(nP+i)];
            SubPopDataName=['SubPopData',num2str(ObjIndex(UsableIndex(i)))];
            Pop(nP+i)=TempPop(UsableIndex(i));
            PopData.(PopDataName)=SubPopData.(SubPopDataName);
            ObjIndex(UsableIndex(i))=0;
        end
        nP=nP+UsableNum;
    end
end
