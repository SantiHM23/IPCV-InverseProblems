function decv = deconvolusion(image, impulse, regularisation, mu)
    %1. Construct h as the N-point FFT of the impulse response.
    h = MyFFT2RI(impulse, size(image,1));
    
    %2. Construct d as the N-point FFT of [1;-1].
    dx = MyFFT2RI(regularisation, size(image,1));
    dy = MyFFT2RI(regularisation', size(image,1));
    
    %3. Construct the vector gPLS containing the transfer function (8).
    gPLS = ctranspose(h)./(abs(h.^2) + mu*(abs(dx.^2) + abs(dy.^2)));
    
    %4. Construct y as the FFT of the observation vector.
    y = MyFFT2(image);
    
    %5. Compute bx as the product between the transfer function gPLS and y.
    bx = gPLS.*y;
    
    %6. Compute the inverse FFT of bx to obtain the solution bx in the spatial domain.
    decv = MyIFFT2(bx);
end