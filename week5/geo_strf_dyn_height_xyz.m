function gz = geo_strf_dyn_height_xyz(sa,ct,p,pref)
%
% Function: gz=geo_strf_dyn_height_xyz(SA,CT,P,Pref)
%
% This is a wrapper to allow for dynamic height calculation with 
% 3D array input for SA, CT, P (x,y,z) where 3rd dimension is the 
% depth. It returns gZ as 3D array (x,y,z)

N=size(sa);
gz=zeros(N);
% do the calculation for each water column
for i=1:N(1)
    for j=1:N(2)
        sa1=double(squeeze(sa(i,j,:)));
        ct1=double(squeeze(ct(i,j,:)));
        p1=double(squeeze(p(i,j,:)));
        p1(isnan(sa1+ct1))=NaN;
        zbot=max(p1);
        if zbot >= pref
            gz(i,j,:)=gsw_geo_strf_dyn_height(sa1,ct1,p1,pref);
        else
            gz(i,j,:)=NaN;
        end
    end
end

return;

