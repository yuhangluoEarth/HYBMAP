tile_number = 6;

for year = 2000:1:2020
year
ESACCI_Y = int16(imread(['...\ESACCI-LC-L4-LCCS-Map-300m-P1Y-',num2str(year),'-v2.0.7cds.tif']));
lc = [0,10,11,12,20,30,40,50,60,61,62,70,71,72,80,81,82,90,100,110,120,121,122,130,140,150,151,152,153,160,170,180,190,200,201,202,210,220];
for tile_n = 1:1:tile_number
x_number = 43200/tile_number;
y_number = 21600/tile_number;
mat_lcc = ones(x_number,y_number,38).*nan;
for lc_i = 1:1:38
    lc_i
    lcc = lc(lc_i);
    Cropland = (ESACCI_Y == lcc );
    for i = ((tile_n-1) * x_number + 1):1:(tile_n * x_number)
        for j = ((tile_n-1) * y_number + 1):1:(tile_n * y_number)
            mat = Cropland((3*i-2):(3*i),(3*j-2):(3*j));
            number = sum(mat,'all','omitnan');
            mat_lcc(i,j,lc_i) = number./9;
        end
    end
end
save(['...\ESACCI_Ratio_',num2str(year),'_',num2str(tile_n)],'mat_lcc') 
end
end
