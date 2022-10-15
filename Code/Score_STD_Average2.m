%%
readpath = '...\LCAff_2010\';
HYBMAP_LC = double(imread([readpath,'HYBMAP_LV2_2010_LC.tif']));
HYBMAP_Aff = double(imread([readpath,'HYBMAP_LV2_2010_Aff.tif']));
mask = double(imread('...\Mask_Global3.tif'));
mask1 = double((mask<15)&(mask>0));
mask1(mask1 == 0) = NaN;
mask1(18001:21600,:)=[];
lc_mean_sd = ones(2,17)*nan;

for lc_i = 1:1:17
    tic
    lc_i
    Aff_score = HYBMAP_Aff;
    Aff_score(HYBMAP_LC ~= lc_i) = NaN;
    Aff_score_masked = Aff_score.*mask1;
    aver_Aff_mean = mean(Aff_score_masked,'all','omitnan');
    aver_Aff_sd = std(Aff_score_masked,0,'all','omitnan');
    lc_mean_sd(1,lc_i) =  aver_Aff_mean;
    lc_mean_sd(2,lc_i) =  aver_Aff_sd;
    toc
end
csvwrite('...\Score_Average_17.csv',lc_mean_sd)
%%
readpath = '...\zResult2\Step2\';
HYBMAP_LC = double(imread([readpath,'HYBMAP_LV1_2010_LC.tif']));
HYBMAP_Aff = double(imread([readpath,'HYBMAP_LV1_2010_Aff.tif']));
mask = double(imread('...\Mask_Global3.tif'));
mask1 = double((mask<15)&(mask>0));
mask1(mask1 == 0) = NaN;
mask1(18001:21600,:)=[];
lc_mean_sd = ones(2,11)*nan;

for lc_i = [4,8,9]
    tic
    Aff_score = HYBMAP_Aff;
    Aff_score(HYBMAP_LC ~= lc_i) = NaN;
    Aff_score_masked = Aff_score.*mask1;
    aver_Aff_mean = mean(Aff_score_masked,'all','omitnan');
    aver_Aff_sd = std(Aff_score_masked,0,'all','omitnan');
    lc_mean_sd(1,lc_i) =  aver_Aff_mean;
    lc_mean_sd(2,lc_i) =  aver_Aff_sd;
    toc
end
csvwrite('...\Score_Average_11.csv',lc_mean_sd)