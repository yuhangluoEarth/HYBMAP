library(ggplot2)
require(devEMF)
library(dplyr)
library(reshape2)

data.forest <-read.csv("Area_MODIS_lucc_area2.csv")
colnames(data.forest) <- c("Year",'Evergreen Needleleaf Forests','Evergreen Broadleaf Forests',	'Deciduous Needleleaf Forests',
                           'Deciduous Broadleaf Forests',	'Mixed Forests',	'Closed Shrublands',	'Open Shrublands',	'Woody Savannas',
                           'Savannas',	'Grasslands',	'Permanent Wetlands',	'Croplands',	'Urban and Built-up Lands',	
                           'Cropland/Natural Vegetation Mosaics',	'Permanent Snow and Ice',	'Barren',	'Water Bodies','Forests-LV1','Shurblands-LV1','Savannas-LV1')
data.forest.melt <- melt(data.forest,id.vars = "Year",variable.name = "LC",value.name = "value")

data.forest <-read.csv("Area_HYBMAP_lucc_area2.csv")
colnames(data.forest) <- c("Year",'Evergreen Needleleaf Forests','Evergreen Broadleaf Forests',	'Deciduous Needleleaf Forests',
                           'Deciduous Broadleaf Forests',	'Mixed Forests',	'Closed Shrublands',	'Open Shrublands',	'Woody Savannas',
                           'Savannas',	'Grasslands',	'Permanent Wetlands',	'Croplands',	'Urban and Built-up Lands',	
                           'Cropland/Natural Vegetation Mosaics',	'Permanent Snow and Ice',	'Barren',	'Water Bodies','Forests-LV1','Shurblands-LV1','Savannas-LV1')

data.forest.melt2 <- melt(data.forest,id.vars = "Year",variable.name = "LC",value.name = "value_HYB")
data.forest.melt3 <- cbind(data.forest.melt,data.forest.melt2)
data.forest.melt3 <- data.forest.melt3[,-(4:5)]
#realm.melt.all2 <- within(realm.melt.all2,LUCC_Change<- factor(LUCC_Change,levels = c("HumVeg","NatVeg","NatNVeg")))
pdf(file = "MODIS_HYBMAP_LUCArea3.pdf",width = 13,height = 8)
ggplot(data = data.forest.melt3)+
  geom_smooth(aes(x = Year,y = value/1000, color = LC),stat = "identity",position = "dodge",size =1,linetype = 2)+
#  geom_point(aes(x = Year,y = value/1000, color = LC),stat = "identity",position = "dodge",size =1.5)+
  geom_smooth(aes(x = Year,y = value_HYB/1000, color = LC),stat = "identity",position = "dodge",size =1)+
#  geom_point(aes(x = Year,y = value_HYB/1000, color = LC),stat = "identity",position = "dodge",size =1.5)+
  scale_x_continuous(limits = c(2000,2020),breaks = c(2000,2004,2008,2012,2016,2020))+
  scale_color_manual(values = c('#05450a', '#086a10', '#54a708', '#78d203', '#009900', '#c6b044', '#dcd159',
                                '#dade48', '#fbff13', '#b6ff05', '#27ff87', '#c24f44', '#a5a5a5', '#ff6d4c',
                                '#69fff8', '#e0e593', '#1c0dff','#007e1e','#c3a619','#dde10c'))+#e0e593#f9ffa4
  theme_bw()+
  xlab('Year')+
  ylab(expression(paste("Land cover area ",(10^3*km^2))))+
  facet_wrap(.~LC, scales = "free_y")+
  theme(legend.position = "none")
dev.off()