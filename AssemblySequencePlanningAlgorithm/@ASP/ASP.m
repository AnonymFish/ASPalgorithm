% Copyright (c) 2018, Nelson
% Project Code: Call MoFwo
% Project Title: MOFWO/D for Selective Assembly
% Muti-Objective firework Algorithm based on Decomposition
% Publisher: Nelson

% Contact Info: nansir@zju.edu.cn, 664995827@qq.com
% Function Info: ASP class

classdef ASP<handle
    properties(Access=public)
        nIter=100;%MaxGeneration
        nPop=100;%PopSize
        nPosition=50;%PositionSize
        nVariable=1;%Variable or parts size
        nObj=2;%ObjSize
        cRate=0.9;% genetic rate
        MinMax=0;%min-0,max-1
        nSparks=10;
        
        Pop=[];
        PopData=[];
    end
    properties(Transient)
    end
    
    methods(Access=public)
        function obj=ASP(varargin)%MaxGeneration,PopSize,Loudness,...PulseRate,Alpha,Gamma,Range,Dimension
            
            %%Input setting
            p=inputParser;
            
            ValidatePopSize=@(x)validateattributes(x,{'numeric'},{'>=',10});
            ValidatePositionSize=@(x)validateattributes(x,{'numeric'},{'nonnegative'});
            ValidateObjSize=@(x)validateattributes(x,{'numeric'},{'>=',2});
            ValidateIterationSize=@(x)validateattributes(x,{'numeric'},{'>=',100});
            ValidateMinMax=@(x)validateattributes(x,{'numeric'},{'binary'});
            ValidatecRate=@(x)validateattributes(x,{'numeric'},{'>=',0,'<=',1});
            ValidatenVariable=@(x)validateattributes(x,{'numeric'},{'nonnegative'});
            ValidateSparkSize=@(x)validateattributes(x,{'numeric'},{'nonnegative'});

            defaultMaxGeneration=100;
            defaultPopSize=20;
            defaultPositionSize=50;
            defaultObjSize=2;
            defaultMinMax=0;
            defaultcRate=0.9;
            defaultnVariable=1;
            defaultnSparks=10;
            
            p.addParameter('MaxGeneration',defaultMaxGeneration,ValidateIterationSize);
            p.addParameter('PopSize',defaultPopSize,ValidatePopSize);
            p.addParameter('PositionSize',defaultPositionSize,ValidatePositionSize);
            p.addParameter('ObjSize',defaultObjSize,ValidateObjSize);
            p.addParameter('MinMax',defaultMinMax,ValidateMinMax);
            p.addParameter('cRate',defaultcRate,ValidatecRate);
            p.addParameter('VariableSize',defaultnVariable,ValidatenVariable);
            p.addParameter('SparkSize',defaultnSparks,ValidateSparkSize);
            
            p.parse(varargin{:});
            obj.nIter=p.Results.MaxGeneration;
            obj.nPop=p.Results.PopSize;
            obj.nPosition=p.Results.PositionSize;
            obj.nObj=p.Results.ObjSize;
            obj.MinMax=p.Results.MinMax;
            obj.cRate=p.Results.cRate;
            obj.nVariable=p.Results.VariableSize;
            obj.nSparks=p.Results.SparkSize;
        end
        Initialization(obj,type,data);
        EvolutionProcess(obj,type,data);
        CallASP(obj,ObjectiveType,data);
    end
    methods(Static)
        [Pop,PopData]=SelectNextPop(TempPop,nPop,SubPopData,type,data);
    end
end
