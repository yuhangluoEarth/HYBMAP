%LV2 Legend Forest
ESACCI_Legend_Forest = xlsread('...\IGBP_LV2\Forest\ESA_CCI-LC_Maps_Legend.xlsx','Score','B:F');
GLC_FCS30_Legend_Forest = xlsread('...\IGBP_LV2\Forest\GLC_FCS30.xlsx','Score','B:F');
MODIS_Legend_Forest = xlsread('...\IGBP_LV2\Forest\MCD12_User_Guide_V6.xlsx','Score','B:F');
Globeland30_Legend_Forest = xlsread('...\IGBP_LV2\Forest\GlobeLand30_cate.xlsx','Score','B:F');
%LV2 Legend Savannas
ESACCI_Legend_Savannas = xlsread('...\IGBP_LV2\Savannas\ESA_CCI-LC_Maps_Legend.xlsx','Score','B:C');
GLC_FCS30_Legend_Savannas = xlsread('...\IGBP_LV2\Savannas\GLC_FCS30.xlsx','Score','B:C');
MODIS_Legend_Savannas = xlsread('...\IGBP_LV2\Savannas\MCD12_User_Guide_V6.xlsx','Score','B:C');
Globeland30_Legend_Savannas = xlsread('...\IGBP_LV2\Savannas\GlobeLand30_cate.xlsx','Score','B:C');
%LV2 Legend Shrublands
ESACCI_Legend_Shrublands = xlsread('...\IGBP_LV2\Shrublands\ESA_CCI-LC_Maps_Legend.xlsx','Score','B:C');
GLC_FCS30_Legend_Shrublands = xlsread('...\IGBP_LV2\Shrublands\GLC_FCS30.xlsx','Score','B:C');
MODIS_Legend_Shrublands = xlsread('...\IGBP_LV2\Shrublands\MCD12_User_Guide_V6.xlsx','Score','B:C');
Globeland30_Legend_Shrublands = xlsread('...\IGBP_LV2\Shrublands\GlobeLand30_cate.xlsx','Score','B:C'); 
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
    pathout = ['...\',char(region)];
    region_split_lcc(input_path,fishet,pathout,ESACCI_Legend,GLC_FCS30_Legend,Globeland30_Legend,MODIS_Legend, ...
    ESACCI_Legend_Forest,GLC_FCS30_Legend_Forest,MODIS_Legend_Forest,Globeland30_Legend_Forest, ...
    ESACCI_Legend_Savannas,GLC_FCS30_Legend_Savannas,MODIS_Legend_Savannas,Globeland30_Legend_Savannas, ...
    ESACCI_Legend_Shrublands,GLC_FCS30_Legend_Shrublands,MODIS_Legend_Shrublands,Globeland30_Legend_Shrublands)
end
