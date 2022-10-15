function Geotiffwrite_Result(x,y,locate4,value4,All_M_Forest4tao,path_output,year)
%mask = double(imread('G:\LUCC_China\aLandCover_AllYear2\zResult\locate_2020Mask.tif'));
%mask1 = double(mask<14);
%mask1(mask1 == 0) = nan;
mask_value = double(value4 > 0.01);
%mask_value(mask_value ==0) = nan; 
%对应的经纬度
x_min = (x-1)*60-180;
x_max = x*60-180;
y_min = 90-(y-1)*30;
y_max = 90-y*30;
%地理参考系的建立
GeoRef = georasterref('Rastersize',[3600,7200],'Latlim',[y_max,y_min],'Lonlim',[x_min,x_max]);
%数据的写出
lccs_Tif = [path_output,'\locate_',num2str(year),'_',num2str(x),'_',num2str(y),'_LV1.tif'];
locate4_flip = flipud(locate4);
geotiffwrite(lccs_Tif,int8(locate4_flip),GeoRef) 
lccs_Tif_v = [path_output,'\value_',num2str(year),'_',num2str(x),'_',num2str(y),'_LV1.tif'];
value4_flip = flipud(value4.*mask_value);
geotiffwrite(lccs_Tif_v,int16(value4_flip.*10000),GeoRef)
lccs_Tif_Forest4tao = [path_output,'\Forest4tao_',num2str(year),'_',num2str(x),'_',num2str(y),'_LV1.tif'];
All_M_Forest4tao_flip = flipud(All_M_Forest4tao.*mask_value);
geotiffwrite(lccs_Tif_Forest4tao,int16(All_M_Forest4tao_flip.*10000),GeoRef)
end