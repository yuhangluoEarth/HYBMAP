function reclassR = reclassify2IGBP(IGBP_LV2_4)
    barren = (IGBP_LV2_4 ==1)*16;
    natcrop = (IGBP_LV2_4 ==2)*14;
    crop = (IGBP_LV2_4 ==3)*12;
    grass = (IGBP_LV2_4 ==5)*10;
    ice = (IGBP_LV2_4 ==6)*15;
    wetland = (IGBP_LV2_4 ==7)*11;
    urban = (IGBP_LV2_4 ==10)*13;
    water = (IGBP_LV2_4 ==11)*17;
    DBF = (IGBP_LV2_4 ==41)*4;
    DNF = (IGBP_LV2_4 ==42)*3;
    EBF = (IGBP_LV2_4 ==43)*2;
    ENF = (IGBP_LV2_4 ==44)*1;
    MF = (IGBP_LV2_4 ==45)*5;
    Savannas = (IGBP_LV2_4 ==81)*9;
    WoodySavannas = (IGBP_LV2_4 ==82)*8;
    ClosedShrub = (IGBP_LV2_4 ==91)*6;
    OpenShrub = (IGBP_LV2_4 ==92)*7;
    %
    reclassR = barren + natcrop + crop + grass + ice + wetland + urban + water + ...
        DBF + DNF + EBF + ENF + MF + Savannas + WoodySavannas + ClosedShrub + OpenShrub;
end
