function Geotiffwrite_ResultLV2(x,y,locate4,value4,path_output,year)
%mask = double(imread('G:\LUCC_China\aLandCover_AllYear2\zResult\locate_2020Mask.tif'));
%mask1 = double(mask<14);
%mask1(mask1 == 0) = nan;
%对应的经纬度
x_min = (x-1)*60-180;
x_max = x*60-180;
y_min = 90-(y-1)*30;
y_max = 90-y*30;

%地理参考系的建立
GeoRef = georasterref('Rastersize',[3600,7200],'Latlim',[y_max,y_min],'Lonlim',[x_min,x_max]);
%数据的写出
lccs_Tif = [path_output,'\locate_',num2str(year),'_',num2str(x),'_',num2str(y),'_LV2.tif'];
locate4_flip = flipud(locate4);
geotiffwrite(lccs_Tif,int8(locate4_flip),GeoRef) 
lccs_Tif_v = [path_output,'\value_',num2str(year),'_',num2str(x),'_',num2str(y),'_LV2.tif'];
value4_flip = flipud(value4);
geotiffwrite(lccs_Tif_v,int16(value4_flip.*10000),GeoRef)
end