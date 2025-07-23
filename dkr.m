% Читання первинного зображення
Ioriginal = imread('cameraman.tif');

% Імітація розмиття від руху без шуму
len = 21;
theta = 11;
PSF = fspecial('motion', len, theta);
Idouble = im2double(Ioriginal);
blurred = imfilter(Idouble, PSF, 'conv', 'circular');

% Відновлення розмитого зображення без шуму
wnr1 = deconvwnr(blurred, PSF);

% Імітація розмиття від руху і гаусівського шуму
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);

% Відновлення розмитого зашумленого зображення без оцінки шуму
wnr2 = deconvwnr(blurred_noisy, PSF);

% Відновлення розмитого зашумленого зображення з оцінкою шуму
signal_var = var(Idouble(:));
NSR = noise_var / signal_var;
wnr3 = deconvwnr(blurred_noisy, PSF, NSR);

% Імітація розмиття від руху і квантуючого шуму 8-бітного зображення
blurred_quantized = imfilter(Ioriginal, PSF, 'conv', 'circular');

% Відновлення розмитого квантованого зображення без оцінки шуму
wnr4 = deconvwnr(blurred_quantized, PSF);

% Відновлення розмитого квантованого зображення з оцінкою шуму
uniform_quantization_var = (1/256)^2 / 12;
NSR = uniform_quantization_var / signal_var;
wnr5 = deconvwnr(blurred_quantized, PSF, NSR);

% Виведення усіх зображень на одному полотні
figure;

subplot(3, 3, 1);
imshow(Ioriginal);
title('Оригінальне зображення');

subplot(3, 3, 2);
imshow(blurred);
title('Розмите зображення');

subplot(3, 3, 3);
imshow(wnr1);
title('Відновлене розмите зображення без шуму');

subplot(3, 3, 4);
imshow(blurred_noisy);
title('Розмите і зашумлене зображення');
subplot(3, 3, 4);
imhist(blurred_noisy); % Додайте гістограму зашумленого зображення

subplot(3, 3, 5);
imshow(wnr2);
title('Відновлення розмитого зашумленого зображення (NSR = 0)');

subplot(3, 3, 6);
imshow(wnr3);
title('Відновлення розмитого зашумленого зображення (оцінений NSR)');

subplot(3, 3, 7);
imshow(blurred_quantized);
title('Розмите квантоване зображення');
subplot(3, 3, 7);
imhist(blurred_quantized); % Додайте гістограму зашумленого зображення

subplot(3, 3, 8);
imshow(wnr4);
title('Відновлення розмитого квантованого зображення (NSR = 0)');

subplot(3, 3, 9);
imshow(wnr5);
title('Відновлення розмитого квантованого зображення (оцінений NSR)');