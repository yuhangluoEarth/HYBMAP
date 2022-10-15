load('...\cellwt_1km.mat','-mat')
mask = double(imread('...\locate_2020Mask.tif'));
mask1 = double(mask<254);
mask1(mask1 == 0) = NaN;
yr_area = ones(21,11)*nan;
for year = 2000:1:2020
    locate = double(imread(['...\locate_',num2str(year),'_4tao.tif']));
    for i = 1:1:17
        locate = locate.*mask1;
        locate_i  = double(locate == i);
        value_wt = locate_i.*cellwt2;
        yr_area(year - 1999, i) = sum(value_wt,[1,2],'omitnan');
    end
end
csvwrite('...\lucc_area.csv',yr_area)