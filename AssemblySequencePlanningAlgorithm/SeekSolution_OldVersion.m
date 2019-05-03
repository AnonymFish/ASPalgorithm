% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP function:Seek Solutions

function [Pop,PopData,nP]=SeekSolution(i,nP,nPop,isEqual,NumOfCirculation,Pop,PopData,SubPopData,TempPop,ObjIndex)

% Seek solution not repetitve,and if it has to have repetitive solutions,
% only one repetitive for one solution at one time, then two repetitives
% then three repetitives....

while i
    if isequal(nP,nPop)
        break;
    elseif i>length(ObjIndex)
        z=1;
        NumOfCirculation=NumOfCirculation+1;
        TempPop2=TempPop([TempPop.isProcessed]==0);
        ObjIndex2=ObjIndex(ObjIndex~=0);
        [Pop,PopData,nP]=SeekSolution(z,nP,nPop,isEqual,NumOfCirculation,Pop,PopData,SubPopData,TempPop2,ObjIndex2);
    else
        for j=1:nP
            if TempPop(i).Position==Pop(j).Position
                isEqual=isEqual+1;
            end
        end
        if ~isEqual||isEqual==NumOfCirculation
            nP=nP+1;
            PopDataName=['PopData',num2str(nP)];
            SubPopDataName=['SubPopData',num2str(ObjIndex(i))];
            Pop(nP)=TempPop(i);
            PopData.(PopDataName)=SubPopData.(SubPopDataName);
            TempPop(i).isProcessed=1;
            ObjIndex(i)=0;
            isEqual=0;
            i=i+1;
        else
            i=i+1;
            isEqual=0;
            continue;
        end
    end
end