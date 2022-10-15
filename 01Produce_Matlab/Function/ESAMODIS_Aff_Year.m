function GLOBGLC_Change_Aff_Score = ESAMODIS_Aff_Year(input_path_Aff,x,y,year,ESACCI_Aff_Score,MODIS_Aff_Score)
    if year < 2006
        year0 = 2000;
        MODESA_0_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2000_',num2str(x),'_',num2str(y),'.mat']));
        MODESA_5_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2005_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_0_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2000_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_5_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2005_',num2str(x),'_',num2str(y),'.mat']));
    elseif (year>2005)&&(year<2011)
        year0 = 2005;
        MODESA_0_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2005_',num2str(x),'_',num2str(y),'.mat']));
        MODESA_5_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2010_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_0_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2005_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_5_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2010_',num2str(x),'_',num2str(y),'.mat']));        
    elseif (year>2010)&&(year<2016)
        year0 = 2010;
        MODESA_0_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2010_',num2str(x),'_',num2str(y),'.mat']));
        MODESA_5_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2015_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_0_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2010_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_5_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2015_',num2str(x),'_',num2str(y),'.mat']));             
    else
        MODESA_0_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2015_',num2str(x),'_',num2str(y),'.mat']));
        MODESA_5_Aff_Score = struct2array(load([input_path_Aff,'\MODESA_Aff_2020_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_0_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2015_',num2str(x),'_',num2str(y),'.mat']));
        GLOBGLC_5_Aff_Score = struct2array(load([input_path_Aff,'\GLOBGLC_Aff_2020_',num2str(x),'_',num2str(y),'.mat']));             
    end
    %year of modesa
    MODESA_year_Aff_Score = (ESACCI_Aff_Score + MODIS_Aff_Score);
    %change
    MODESA_Change_Aff_Score = (MODESA_year_Aff_Score - MODESA_0_Aff_Score) - (MODESA_5_Aff_Score - MODESA_0_Aff_Score).*((year - year0)/5);
    % revise the change
    k = (GLOBGLC_5_Aff_Score - GLOBGLC_0_Aff_Score + 0.001)./(MODESA_5_Aff_Score - MODESA_0_Aff_Score + 0.001);
    k(k > 3) = 3;
    k(k < -3) = -3;
    k(isinf(k)) = 0;
    GLOBGLC_Change_Aff_Score = k.* MODESA_Change_Aff_Score;
end