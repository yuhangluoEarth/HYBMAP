function aff_score = gen_aff_score_Savannas(single_mat_lcc,Legend,m,n)
%m=3600;n=7200;
aff_score = ones(m,n,2).*nan;
for i = 1:1:m
    single_mat_lcc_i = squeeze(single_mat_lcc(i,:,:));
    single_mat_lcc_Trans_i = single_mat_lcc_i * Legend;
    aff_score(i,:,:) = single_mat_lcc_Trans_i;
end
end