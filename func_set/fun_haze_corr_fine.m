function [haze_corr,dehazing_est] = fun_haze_corr_fine(input_img,I0,size_window,mask)

[m,n] = size(input_img);
haze_dark = get_dark_channel( input_img, size_window);

omega_a = 0;
omega_b = 1;
itter_n = 1; % iteration times
e = 0.002;
while true
    F = get_F(itter_n);
    Fn = F(itter_n+2);
    if Fn < (omega_b-omega_a)/e
        itter_n = itter_n+1;
    else
        break
    end
end
F = get_F(itter_n);

x2 = omega_a + F(itter_n-1)/F(itter_n) * (omega_b - omega_a);
x1 = omega_b - F(itter_n-1)/F(itter_n) * (omega_b - omega_a);
while abs(omega_b - omega_a) > e
    haze_est = 1 - x2 * haze_dark;   
    x = guided_filter(input_img, haze_est, 15, 0.001);
    dehazing_est = max(reshape(x, m, n),0.1);
    haze_corr = ((input_img - 1) ./ dehazing_est.^2) + 1;
    fx2 = abs(I0 - mean(mean(haze_corr(mask))));
    
    haze_est = 1 - x1 * haze_dark;   
    x = guided_filter(input_img, haze_est, 15, 0.001);
    dehazing_est = max(reshape(x, m, n),0.1);
    haze_corr = ((input_img - 1) ./ dehazing_est.^2) + 1;
    fx1 = abs(I0 - mean(mean(haze_corr(mask))));
    
    if fx2 >= fx1
        omega_b = x2;
        x2 = x1;
        x1 = omega_a + omega_b - x2;
    else
        omega_a = x1;
        x1 = x2;
        x2 = omega_a + omega_b - x1;
    end

end
haze_est = 1 - (omega_a+omega_b)/2 * haze_dark;   
x = guided_filter(input_img, haze_est, 15, 0.001);
dehazing_est = max(reshape(x, m, n),0.1);

haze_corr = ((input_img - 1) ./ dehazing_est.^2) + 1;
disp(['haze_corr = ',num2str( (omega_a + omega_b) / 2 ),...
    '; mean = ',num2str(mean(mean(haze_corr(mask)))),...
    '; avg = ',num2str(sum(sum((haze_corr>1))) / sum(sum(mask)))])


end
