classdef gaborFeatExtractor<featExtractor
    properties 
        windowSize=[3,3];
        gaborData;
        funcList;
    end
    methods 
        
        function obj=gaborFeatExtractor(windowSize,options) 
            obj.windowSize=windowSize;
            obj.gaborData =  load('gaborbank3D.mat','gaborstruct').gaborstruct;
            obj.funcList = {@mean,@std,@kurtosis};
        end
        
        function [final_stats,statNameList]=extract(obj,image,label)
            [gabFeat,gabNames] = obj.extract_raw(image.*label); 
            [final_stats,statNameList] = obj.extract_stats(gabFeat,gabNames);          
        end 
        
        function [gabfeats,gabnames]= extract_raw(obj,vol)
            fcount =0; 
            for i =1:5
                fcount= fcount + 1; 
                g_c = jconvn(vol,obj.gaborData(1).cos);
                g_s = jconvn(vol,obj.gaborData(1).sin);
                gabfeats(:,:,:,fcount) = sqrt(g_c.*g_c + g_s.*g_s);
                gabnames(fcount) = {obj.gaborData(1).title};
            end
        end
        
        function [final_stats,statNameList]= extract_stats(obj,feats,feat_names)
            final_stats = zeros(1,size(feats,4)*length(obj.funcList)); 
            statNameList = cell(1,size(feats,4)*length(obj.funcList));
            f_count = 0;
           for f=1:size(feats,4)
               feat_vol = feats(:,:,:,f);
               for i=1:length(obj.funcList)
                   f_count = f_count+1;
                   stat_name = sprintf('%s_%s',char(obj.funcList{i}),feat_names{f} );
                   final_stats(f_count) = obj.funcList{i}(feat_vol(:)); 
                   statNameList{f_count} = stat_name;
               end
           end
        end
        
        function names=featNames(image,labels)
            namaes = {'1','2','3'};
        end 
    
    end
end 

