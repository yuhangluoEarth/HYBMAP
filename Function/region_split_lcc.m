function region_split_lcc(input_path,fishet,pathout,ESACCI_Legend,GLC_FCS30_Legend,Globeland30_Legend,MODIS_Legend, ...
    ESACCI_Legend_Forest,GLC_FCS30_Legend_Forest,MODIS_Legend_Forest,Globeland30_Legend_Forest, ...
    ESACCI_Legend_Savannas,GLC_FCS30_Legend_Savannas,MODIS_Legend_Savannas,Globeland30_Legend_Savannas, ...
    ESACCI_Legend_Shrublands,GLC_FCS30_Legend_Shrublands,MODIS_Legend_Shrublands,Globeland30_Legend_Shrublands)
[m_fish,n_fish] = size(fishet);
for i_fish = 1:1:m_fish
    for year = 2000:1:2020
    y = fishet(i_fish,1);   
    x = fishet(i_fish,2);
    %ESACCI
    mat_lcc = struct2array(load([input_path,'\ESACCI_mat_ratio\ESACCI_Ratio_',num2str(year),'_',num2str(x),'_',num2str(y),'.mat']));
    mat_lcc(isnan(mat_lcc))=0;
    [m,n,~] = size(mat_lcc);
    ESACCI_Aff_Score = gen_aff_score(mat_lcc,ESACCI_Legend,m,n);
    ESACCI_Aff_Score_Forest = gen_aff_score_Forest(mat_lcc,ESACCI_Legend_Forest,m,n);
    ESACCI_Aff_Score_Savannas = gen_aff_score_Savannas(mat_lcc,ESACCI_Legend_Savannas,m,n);
    ESACCI_Aff_Score_Shrublands = gen_aff_score_Shrublands(mat_lcc,ESACCI_Legend_Shrublands,m,n);
    clear mat_lcc
    %MODIS
    if year == 2000
        yearMODIS = 2001;
    else
        yearMODIS = year;
    end
    mat_lcc = struct2array(load([input_path,'\MODIS_mat_ratio\MCD12Q1_Ratio_',num2str(yearMODIS),'_',num2str(x),'_',num2str(y),'.mat']));
    mat_lcc(isnan(mat_lcc))=0;
    [m,n,~] = size(mat_lcc);
    MODIS_Aff_Score = gen_aff_score(mat_lcc,MODIS_Legend,m,n);
    MODIS_Aff_Score_Forest = gen_aff_score_Forest(mat_lcc,MODIS_Legend_Forest,m,n);
    MODIS_Aff_Score_Savannas = gen_aff_score_Savannas(mat_lcc,MODIS_Legend_Savannas,m,n);
    MODIS_Aff_Score_Shrublands = gen_aff_score_Shrublands(mat_lcc,MODIS_Legend_Shrublands,m,n);
    clear mat_lcc
    %Change of MODESA
    input_path_Aff = [input_path,'\Aff_MODESA\',char(region)];
    GLOBGLC_Change_Aff_Score = ESAMODIS_Aff_Year(input_path_Aff,x,y,year,ESACCI_Aff_Score,MODIS_Aff_Score);
    %GLC_FCS30
    mat_lcc = GLC_FCS30_inner(input_path,year,x,y);
    mat_lcc(isnan(mat_lcc))=0;
    [m,n,~] = size(mat_lcc);
    GLC_FCS30_Aff_Score = gen_aff_score(mat_lcc,GLC_FCS30_Legend,m,n);
    GLC_FCS30_Aff_Score_Forest = gen_aff_score_Forest(mat_lcc,GLC_FCS30_Legend_Forest,m,n);
    GLC_FCS30_Aff_Score_Savannas = gen_aff_score_Savannas(mat_lcc,GLC_FCS30_Legend_Savannas,m,n);
    GLC_FCS30_Aff_Score_Shrublands = gen_aff_score_Shrublands(mat_lcc,GLC_FCS30_Legend_Shrublands,m,n);
    clear mat_lcc
    %GlobeLand30
    mat_lcc = GlobeLand30_inner(input_path,year,x,y);
    mat_lcc(isnan(mat_lcc))=0;
    [m,n,~] = size(mat_lcc);
    Globeland30_Aff_Score = gen_aff_score(mat_lcc,Globeland30_Legend,m,n);
    Globeland30_Aff_Score_Forest = gen_aff_score_Forest(mat_lcc,Globeland30_Legend_Forest,m,n);
    Globeland30_Aff_Score_Savannas = gen_aff_score_Savannas(mat_lcc,Globeland30_Legend_Savannas,m,n);
    Globeland30_Aff_Score_Shrublands = gen_aff_score_Shrublands(mat_lcc,Globeland30_Legend_Shrublands,m,n);
    clear mat_lcc  
    %Calculate max
    All_M = ESACCI_Aff_Score + MODIS_Aff_Score + GLC_FCS30_Aff_Score + Globeland30_Aff_Score + GLOBGLC_Change_Aff_Score.*(2/3);
    All_M_Forest = ESACCI_Aff_Score_Forest + MODIS_Aff_Score_Forest + GLC_FCS30_Aff_Score_Forest + Globeland30_Aff_Score_Forest;
    All_M_Savannas = ESACCI_Aff_Score_Savannas + MODIS_Aff_Score_Savannas + GLC_FCS30_Aff_Score_Savannas + Globeland30_Aff_Score_Savannas;
    All_M_Shrublands = ESACCI_Aff_Score_Shrublands + MODIS_Aff_Score_Shrublands + GLC_FCS30_Aff_Score_Shrublands + Globeland30_Aff_Score_Shrublands;
    %max locate value
    [value4,locate4]= max(All_M,[],3);
    [value4_Forest,locate4_Forest]= max(All_M_Forest,[],3);
    [value4_Savannas,locate4_Savannas]= max(All_M_Savannas,[],3);
    [value4_Shrublands,locate4_Shrublands]= max(All_M_Shrublands,[],3);
    %ratio-lize
    value4 = value4/4;
    value4_Forest = value4_Forest/4;
    value4_Savannas = value4_Savannas/4;
    value4_Shrublands = value4_Shrublands/4;
    %Combine
    IGBP_LV2_4 = locate4;
    IGBP_LV2_4(locate4 == 4) = 40 + locate4_Forest(locate4 == 4);
    IGBP_LV2_4(locate4 == 8) = 80 + locate4_Savannas(locate4 == 8);
    IGBP_LV2_4(locate4 == 9) = 90 + locate4_Shrublands(locate4 == 9);
    %IGBP_LV2 Value multiply
    IGBP_LV2_4_Value = value4;
    IGBP_LV2_4_Value(locate4 ==4) = value4(locate4 == 4).*value4_Forest(locate4 == 4);
    IGBP_LV2_4_Value(locate4 ==8) = value4(locate4 == 8).*value4_Savannas(locate4 == 8);
    IGBP_LV2_4_Value(locate4 ==9) = value4(locate4 == 9).*value4_Shrublands(locate4 == 9);
    %reclass
    IGBP_LV2_4_reclass = reclassify2IGBP(IGBP_LV2_4);
    %Write Forest
    All_M_Forest4tao = All_M(:,:,4)/4;
    %WriteInTiff
    %mask = double(imread('G:\LUCC_China\aLandCover_AllYear2\zResult\locate_2020Mask.tif'));
    path_output = [pathout,'\LV1'];
    Geotiffwrite_Result(x,y,locate4,value4,All_M_Forest4tao,path_output,year);
    path_output2 = [pathout,'\LV2'];
    Geotiffwrite_ResultLV2(x,y,IGBP_LV2_4_reclass,IGBP_LV2_4_Value,path_output2,year);
    end
end
end