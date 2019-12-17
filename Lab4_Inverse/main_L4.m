close all;
clear all;
clc;

% Load data
%load DataOne
load DataTwo

[m,n] = size(Data);

% Display the frequency domain image
Y = MyFFT2(Data);

% Calculate the convolution matrix
H = MyFFT2RI(IR,m);

reg = [0, 0, 0; 0, -1, 1; 0, 0, 0];
Dx = MyFFT2RI(reg, m);
Dy = MyFFT2RI(reg', m);

X = Y;
K = 1000;
lambda = zeros(size(Data));
z = zeros(size(Data));
Z = MyFFT2(z);
L = MyFFT2(lambda);
rho = 0.7;
eps = 10^(-5);
mu = 0.04; %%%%%%%%%%%%%Optimal value

for rho = 0.1:0.1:1
for k = 1:K
    X = (1./(abs(H).^2 + mu*(abs(Dx).^2 + abs(Dy).^2) + rho)).*(conj(H).*Y - L/2 + rho*Z);
    x = MyIFFT2(X);
    z = max(0, x + (lambda/rho));
    lambda = lambda + rho*(x-z);
    Z = MyFFT2(z);
    L = MyFFT2(lambda);
end


x = MyIFFT2(X);
%x(x<0) = 0;
figureTitle = sprintf('Zoluzion rho=%f', rho);
figure('Name',figureTitle); clf
imagesc(x);
colormap('gray'); colorbar
axis('square', 'off')
end
