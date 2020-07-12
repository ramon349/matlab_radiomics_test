classdef intensityStats<featExtractor
    properties 
        windowSize=[3,3];
        funcList;
    end
    methods 
        function obj=intensityStats(windowSize,funcList)
            obj.windowSize=windowSize;
            if isempty(funcList)
                obj.funcList = {@mean,@std,@var};
            else
                obj.funcList= funcList;
            end
        end
        
        function [feats,feat_names]=extract(obj,image,labels)
            feats = zeros(1,length(obj.funcList));
            feat_names = cell(1,length(obj.funcList));
            flat_img = image(:).*labels(:);
            
            for i=1:length(obj.funcList)
               feats(i) = obj.funcList{i}(flat_img);
               feat_names{i} = sprintf('%s_img',char(obj.funcList{i}));
            end
        end 
        
        function names=featNames(image,labels)
            namaes = {'1','2','3'};
        end 
    
    end
end 

