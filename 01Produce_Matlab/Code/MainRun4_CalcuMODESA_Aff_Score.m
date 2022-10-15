input_path = '...\mat_ratio';
input_path_Legend = '...\Split_region_LV1\';
%for region = ["Africa","NorthAmerica","SouthAmerica","Asia_Europ","Ocean"]
for region = ["Africa","NorthAmerica","SouthAmerica","Asia_Europ","Ocean"]
    if (region == "Africa")
        fishet = [2,3;2,4;3,3;4,3;3,4;4,4;5,4;4,5;5,5];
        elseif (region == "NorthAmerica")
        fishet = [1,1;1,2;1,3;2,1;2,2;2,3;3,2;3,3];
        elseif (region == "SouthAmerica")
        fishet = [3,2;3,3;4,2;4,3;5,2;5,3];
        elseif (region == "Asia_Europ")
        fishet = [1,1;1,3;1,4;1,5;1,6;2,3;2,4;2,5;2,6;3,4;3,5;3,6;4,5;4,6];              
        else
        fishet = [3,1;3,6;4,1;4,2;4,5;4,6;5,1;5,5;5,6];            
    end
    ESACCI_Legend = csvread([input_path_Legend,char(region),'\ESACCI_AllValidation_All8_M.csv'],1,1);
    ESACCI_Legend(:,12) = [];  
    GLC_FCS30_Legend = csvread([input_path_Legend,char(region),'\GLC_FCS30_AllValidation_All8_M.csv'],1,1);
    GLC_FCS30_Legend(:,12) = []; 
    Globeland30_Legend = csvread([input_path_Legend,char(region),'\GlobeLand30_AllValidation_All8_M.csv'],1,1);
    Globeland30_Legend(:,12) = []; 
    MODIS_Legend = csvread([input_path_Legend,char(region),'\MODIS_AllValidation_All8_M.csv'],1,1); 
    MODIS_Legend(:,12) = []; 
    pathout = ['F:\DHJ2021\LUCC_China\Calculation\mat_ratio\Aff_MODESA\',char(region)];
        for year = [2000,2005,2010,2015,2020]
            [m_fish,n_fish] = size(fishet);
                for i_fish = 1:1:m_fish
                    y = fishet(i_fish,1);   
                    x = fishet(i_fish,2);
                    ESACCI_0_M = struct2array(load([input_path,'\ESACCI_mat_ratio\ESACCI_Ratio_',num2str(year),'_',num2str(x),'_',num2str(y),'.mat']));
                    [m,n,~] = size(ESACCI_0_M);
                    ESACCI_0_Aff_Score = gen_aff_score(ESACCI_0_M,ESACCI_Legend,m,n);    
                    if year == 2000
                        year2 = 2001;
                    else
                        year2 = year;
                    end
                    year
                    year2
                    MODIS_0_M = struct2array(load([input_path,'\MODIS_mat_ratio\MCD12Q1_Ratio_',num2str(year2),'_',num2str(x),'_',num2str(y),'.mat']));    
                    MODIS_0_Aff_Score = gen_aff_score(MODIS_0_M,MODIS_Legend,m,n);
                    MODESA_Aff_Score = (MODIS_0_Aff_Score + ESACCI_0_Aff_Score);%no need to divde two, because GLC_FCS30 and GlobeLand30 are two
                    save([pathout,'\MODESA_Aff_',num2str(year),'_',num2str(x),'_',num2str(y),'.mat'],'MODESA_Aff_Score','-v7.3');
                end
        end
end
