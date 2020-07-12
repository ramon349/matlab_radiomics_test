classdef featPipeline
    properties
        extractorList;
        windowSizes;
    end
    methods
        
        function obj=featPipeline(featNames)
            extractorList = cell(1,length(featNames));
            for i=1:length(featNames)
                switch featNames{i}
                    case 'gray'
                        extractorList{i} = intensityStats([3,3],{});
                    case 'gabor'
                        extractorList{i} = gaborFeatExtractor([3,3],{});
                end 
            end
            obj.extractorList = extractorList;
        end
        
        function [feats,f_names] = extract(obj,vol,label)
            feats =[];
            f_names = {};
            for i=1:length(obj.extractorList)
                [f_val,f_name] = obj.extractorList{i}.extract(vol,label);
                feats = [feats,f_val] ;
                f_names = [f_names,f_name]; 
            end
        end
    end
end
