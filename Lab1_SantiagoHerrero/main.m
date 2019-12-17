close all;
clear all;
clc;

% Load data
%load DataOne
load DataTwo

[m,n] = size(Data);

% Display the image
figure(), clf
imagesc(Data);
colormap('gray'); colorbar
axis('square', 'off')

% Display the frequency domain image
Y = MyFFT2(Data);
Y = abs(Y);
figure(), clf
imagesc(Y);
colormap('gray'); colorbar
axis('square', 'off')

% Display the impulse response
figure(), clf
imagesc(IR);
colormap('gray'); colorbar
axis('square', 'off')

figure(), clf
plot(IR);

% Calculate the convolution matrix
H = MyFFT2RI(IR,m);
H = abs(H);

% Display the convolution matrix
figure(), clf
imagesc(H);
colormap('gray'); colorbar
axis('square', 'off')

figure(), clf
plot(H);

% Regularization parameter and mu
reg = [0, 0, 0; 0, -1, 1; 0, 0, 0];
mu = 0.0236;

% Calculate the deconvolution
x = deconvolusion(Data, IR, reg, mu);

figure(), clf
imagesc(x);
colormap('gray'); colorbar
axis('square', 'off')

% Test different mu values
% A = [-10:10];
% for i = 1:size(A,2)
%     mu = 10^A(i);
%     x = deconvolusion(Data, IR, reg, mu);
%     lamb1(i) = (sum(sum(x-TrueImage).^2))/sum(sum(TrueImage).^2);
%     lamb2(i) = (sum(sum(abs(x-TrueImage))))/sum(sum(abs(TrueImage)));
%     lamb3(i) = max(max(abs(x-TrueImage)))/max(max(abs(TrueImage)));
%     val(i) = mu;
%     figure(), clf
%     imagesc(x);
%     colormap('gray'); colorbar
%     axis('square', 'off')
% end
% [m1, i1] = min(lamb1);
% mu1 = val(i1);
% [m2, i2] = min(lamb2);
% mu2 = val(i2);
% [m3, i3] = min(lamb3);
% mu3 = val(i3);
% 
% %Go deeper into mu values
% maxmu = max([mu1, mu2, mu3]);
% minmu = min([mu1, mu2, mu3]);
% cont = 1;
% j = minmu/10;
% k = minmu/100;
% l = maxmu*10;
% for mu = j:k:l
%     x = deconvolusion(Data, IR, reg, mu);
%     lamb1deep(cont) = (sum(sum(x-TrueImage).^2))/sum(sum(TrueImage).^2);
%     lamb2deep(cont) = (sum(sum(abs(x-TrueImage))))/sum(sum(abs(TrueImage)));
%     lamb3deep(cont) = max(max(abs(x-TrueImage)))/max(max(abs(TrueImage)));
%     val(cont) = mu;
%     cont = cont+1;
% end
% [m1deep, i1deep] = min(lamb1deep);
% mu1deep = val(i1deep);
% [m2deep, i2deep] = min(lamb2deep);
% mu2deep = val(i2deep);
% [m3deep, i3deep] = min(lamb3deep);
% mu3deep = val(i3deep);