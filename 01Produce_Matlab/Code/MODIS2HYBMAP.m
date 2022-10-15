%%
%%the LC that MODIS to HYBMAP
MODIS = double(imread('...\zResult2\MODIS2HYBMAP\MODIS_Masked2.tif'));
HYBMAP = double(imread('...\zResult2\MODIS2HYBMAP\HYBMAP31_Masked2.tif'));
MODIS(MODIS == -128) = NaN;
HYBMAP(HYBMAP == -128) = NaN;
mask = (HYBMAP>0);
load cellwt2.mat
cellwt2 = cellwt2(1:18000,:);
HYBMAPneqMODIS = double(HYBMAP ~= MODIS);
HYBMAPneqMODIS(HYBMAPneqMODIS ==0) = NaN;
HYBMAPneqMODIS = HYBMAPneqMODIS.*mask;
MODIS_neq = MODIS.*HYBMAPneqMODIS;
HYBMAP_neq = HYBMAP.*HYBMAPneqMODIS;
neq_tansform = ones(289,3)*nan;
for from = 1:1:17
    for to = 1:1:17
        tic
        from
        to
        i = (from-1).*17 + to;
        if from == to 
            continue
        end
        neq_mask = double((MODIS_neq == from).*(HYBMAP_neq == to));
        neq_mask(neq_mask == 0)= NaN;
        neq_mask_wt = neq_mask.*cellwt2;
        neq_tansform(i, 1) = from;
        neq_tansform(i, 2) = to;
        neq_tansform(i, 3) = sum(neq_mask_wt,[1,2],'omitnan');
        toc
    end
end
csvwrite('...\AllValidation_All8_4\zResult2\MODIS2HYBMAP\MODIS2HYBMAP.csv',neq_tansform)