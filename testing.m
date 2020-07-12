
addpath(genpath('./BrIC_Lab'))
data = load_nii('./avg152T1_LR_nifti.nii.gz');
data_img = double(data.img); 
label = ones(size(data_img));

pipe = featPipeline({'gray','gabor'});
[feats,f_names]= pipe.extract(data_img,label);


