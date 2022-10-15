import arcpy
import glob
import os
proj = '...\\GCS_WGS_1984.prj'
for year in range(2000,2021):
    ##for region in ["Africa","Asia_Europ","NorthAmerica","Ocean","SouthAmerica"]:
    for region in ["Africa","Asia_Europ","NorthAmerica","SouthAmerica","Ocean"]:
        path = '...\\Result2\\'
        in_rasterLC = path + 'zPath_Mosaic\\aTile\\' + region + '\\LV2\\' + 'HYBMAP_LV2_'+ str(year) + '_LC.tif'
        in_rasterAff = path + 'zPath_Mosaic\\aTile\\' + region + '\\LV2\\' + 'HYBMAP_LV2_'+ str(year) + '_Aff.tif'
        in_mask_data = path + 'zContinent\\' + region + '.tif'
        out_rasterLC = path + 'zPath_Mosaic\\Step1\\' + 'HYBMAP_LV2_'+ str(year) + '_' + region + '_LC.tif'
        out_rasterAff = path + 'zPath_Mosaic\\Step1\\' + 'HYBMAP_LV2_'+ str(year) + '_' + region + '_Aff.tif'
        arcpy.gp.ExtractByMask_sa(in_rasterLC, in_mask_data, out_rasterLC) 
        arcpy.gp.ExtractByMask_sa(in_rasterAff, in_mask_data, out_rasterAff)
        print(str(year))
    inws_lv2 = path + 'zPath_Mosaic\\Step1'
    outws_lv2 = path + 'zPath_Mosaic\\Step2'
    rasters_list_lv2locate = glob.glob(os.path.join(inws_lv2, 'HYBMAP_LV2_'+str(year)+'*'+'_LC.tif'))
    rasters_list_lv2value = glob.glob(os.path.join(inws_lv2, 'HYBMAP_LV2_'+str(year)+'*'+'_Aff.tif')) 
    out_name_lv2locate = 'HYBMAP_LV2_'+ str(year) + '_LC.tif'
    out_name_lv2value = 'HYBMAP_LV2_'+ str(year) + '_Aff.tif'
    arcpy.MosaicToNewRaster_management(rasters_list_lv2locate,outws_lv2, out_name_lv2locate, proj,"16_BIT_UNSIGNED", "", "1", "LAST","FIRST")
    arcpy.MosaicToNewRaster_management(rasters_list_lv2value,outws_lv2, out_name_lv2value, proj,"16_BIT_UNSIGNED", "", "1", "LAST","FIRST")
