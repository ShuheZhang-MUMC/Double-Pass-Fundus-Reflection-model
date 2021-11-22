% retinal image enhancement using double pass fundus reflection model

clc
clear
addpath('func_set//');
save_path = 'results//';

type = 2; %  1: CIElab, 2: ycbcr
mult = 1;
show_intermediate = 1;
I0 = 0.55;
gray_thre = 20; % grayvalue threshold in red channel for separating the black background and ROI

tic
[img_name, img_path]=uigetfile('*.*');
raw_img0 = double(imread([img_path,img_name]))/255;

[m0,n0,~] = size(raw_img0);
gauss_size = fix(sqrt(m0*n0)/20);
[raw_img,mask] = prepossing(raw_img0,gray_thre,gauss_size,mult);

if type == 1
    img_ycbcr = rgb2lab(raw_img);
    q_channel = img_ycbcr(:,:,1)/100;
else
    img_ycbcr = rgb2ycbcr_ITU(raw_img);
    q_channel = img_ycbcr(:,:,1);
end


[m,n,~] = size(q_channel);

w_ = fix(sqrt(m*n)/150);    % window size


if show_intermediate == 1 
    [illu_corr,illu_est_coarse] = fun_illu_corr_coarse(q_channel,gauss_size,mask);
    imwrite(illu_corr,['intermediate//coarse_corr_',img_name])
    imwrite(illu_est_coarse,['intermediate//coarse_est_',img_name])
    
    [illu_corr,illu_est_fine] = fun_illu_corr_fine(illu_corr,w_,mask);      % fine illumination correction
    imwrite(illu_corr,['intermediate//fine_corr_',img_name])
    imwrite(illu_est_fine,['intermediate//fine_est_',img_name])
    
    [haze_corr,tran_est_fine] = fun_haze_corr_fine(illu_corr,I0,w_,mask); % dehazing
    imwrite(haze_corr,['intermediate//haze_corr_',img_name])
    imwrite(tran_est_fine,['intermediate//tran_est_',img_name])
else
    [illu_corr,~] = fun_illu_corr_coarse(q_channel,gauss_size,mask);    % coarse illumination correction
    [illu_corr,~] = fun_illu_corr_fine(illu_corr,w_,mask);                  % fine illumination correction
    [haze_corr,~] = fun_haze_corr_fine(illu_corr,I0,w_,mask);             % dehazing
end


if type == 1
    img_ycbcr(:,:,1) = haze_corr*100;
    out_img = lab2rgb(img_ycbcr);
else
    img_ycbcr(:,:,1) = haze_corr;
    out_img = ycbcr2rgb_ITU(img_ycbcr);
end

out_img = out_img .* mask;

out_img_cut = out_img(mult*gauss_size+1:end-mult*gauss_size,...
                      mult*gauss_size+1:end-mult*gauss_size,:);  

imwrite(out_img_cut,[save_path,img_name(1:end-4),'_enhanced.png'])

rmpath('func_set//');
toc

figure();
temp_img = [];
for con = 1:3
    temp_img(:,:,con) = [raw_img0(:,:,con),out_img_cut(:,:,con)];
end
imshow(temp_img,[])
title('left: raw image,   right:enhaned image')














