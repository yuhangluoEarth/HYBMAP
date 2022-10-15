function mat_lcc = GlobeLand30_inner(input_path,year,x,y)
%²åÖµ
    if year < 2010
        Globeland30_2000_M = struct2array(load([input_path,'\Globeland30_mat_ratio\Y2000\Globeland30_2000_',num2str(x),'_',num2str(y),'.mat']));
        Globeland30_2010_M = struct2array(load([input_path,'\Globeland30_mat_ratio\Y2010\Globeland30_2010_',num2str(x),'_',num2str(y),'.mat']));
        mat_lcc = ((2010 - year)/10).*Globeland30_2000_M + ((year - 2000)/10).*Globeland30_2010_M;
    else
        Globeland30_2010_M = struct2array(load([input_path,'\Globeland30_mat_ratio\Y2010\Globeland30_2010_',num2str(x),'_',num2str(y),'.mat']));
        Globeland30_2020_M = struct2array(load([input_path,'\Globeland30_mat_ratio\Y2020\Globeland30_2020_',num2str(x),'_',num2str(y),'.mat']));
        mat_lcc = ((2020 - year)/10).*Globeland30_2010_M + ((year - 2010)/10).*Globeland30_2020_M;
    end
end