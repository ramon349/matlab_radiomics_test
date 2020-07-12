classdef featExtractor
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    methods (Abstract)
        extract(obj,image,labels)
        featNames(obj)
    end
end

