function mat_lcc = GLC_FCS30_inner(input_path,year,x,y)
%²åÖµ
    if year < 2006 
        GLC_FCS30_2000_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2000\GLC_FCS30_2000_',num2str(x),'_',num2str(y),'.mat']));
        GLC_FCS30_2005_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2005\GLC_FCS30_2005_',num2str(x),'_',num2str(y),'.mat']));
        mat_lcc = ((2005 - year)/5).*GLC_FCS30_2000_M + ((year - 2000)/5).*GLC_FCS30_2005_M;
    elseif (year>2005)&&(year<2011)
        GLC_FCS30_2005_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2005\GLC_FCS30_2005_',num2str(x),'_',num2str(y),'.mat']));
        GLC_FCS30_2010_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2010\GLC_FCS30_2010_',num2str(x),'_',num2str(y),'.mat']));          
        mat_lcc = ((2010 - year)/5).*GLC_FCS30_2005_M + ((year - 2005)/5).*GLC_FCS30_2010_M;
    elseif (year>2010)&&(year<2016)
        GLC_FCS30_2010_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2010\GLC_FCS30_2010_',num2str(x),'_',num2str(y),'.mat']));
        GLC_FCS30_2015_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2015\GLC_FCS30_2015_',num2str(x),'_',num2str(y),'.mat']));             
        mat_lcc = ((2015 - year)/5).*GLC_FCS30_2010_M + ((year - 2010)/5).*GLC_FCS30_2015_M;
    else
        GLC_FCS30_2015_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2015\GLC_FCS30_2015_',num2str(x),'_',num2str(y),'.mat']));
        GLC_FCS30_2020_M = struct2array(load([input_path,'\GLC_FCS30_mat_ratio\Y2020\GLC_FCS30_2020_',num2str(x),'_',num2str(y),'.mat']));            
        mat_lcc = ((2020 - year)/5).*GLC_FCS30_2015_M + ((year - 2015)/5).*GLC_FCS30_2020_M;
    end
end