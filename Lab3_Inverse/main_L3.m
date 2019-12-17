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

ax = zeros(m,n);
ay = zeros(m,n);
K = 1000;
mu = 10; %%%%%%%%%%%%%%%Cartoon value
mu = 0.04; %%%%%%%%%%%%%Optimal value
alpha = 0.01; %%%%%%%%%%Cartoon value
muprime = mu/alpha;
muhat = muprime/2;
thres = 0.01; %%%%%%%%%%Cartoon value
thres = 0.9; %%%%%%%%%%%Optimal value
convcell = {};
convergence = zeros(K,2);
i = 1;

X = Y;
for alpha = [0.01 0.25 0.49]
for k = 1:K
    DELTAX = X.*Dx;
    DELTAY = X.*Dy;
    deltax = MyIFFT2(DELTAX);
    deltay = MyIFFT2(DELTAY);

    ax = deltax.*(1-2*alpha*(min(1,thres./abs(deltax))));
    ay = deltay.*(1-2*alpha*(min(1,thres./abs(deltay))));

    Ax = MyFFT2(ax);
    Ay = MyFFT2(ay);
    
    X2 = (1./(abs(H).^2 + muhat*(abs(Dx).^2 + abs(Dy).^2)).*(H'.*Y+ muhat*(conj(Dx).*Ax + conj(Dy).*Ay)));
    convergence(k,1) = k;
    convergence(k,2) = sum(sum(abs(X2-X)));
    X = X2;
end
convcell{i} = convergence;
i = i+1;

x = MyIFFT2(X);
figureTitle = sprintf('T = %f, alpha = %f, mu = %f',thres, alpha, mu);
figure('Name',figureTitle); clf
imagesc(x);
colormap('gray'); colorbar
axis('square', 'off')
end

figure()
subplot(3,1,1)
plot(convcell{1}(:,1), convcell{1}(:,2))
ylim([0 5])
subplot(3,1,2)
plot(convcell{2}(:,1), convcell{2}(:,2))
ylim([0 5])
subplot(3,1,3)
plot(convcell{3}(:,1), convcell{3}(:,2))
ylim([0 5])


