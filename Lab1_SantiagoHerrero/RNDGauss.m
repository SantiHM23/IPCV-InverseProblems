function SampleImage = RNDGauss(MoyGauss,Covariance)	

% Param�tre de Taille
	Taille = length(MoyGauss);
    
% Tirage d'un bruit blanc avec la bonne sym�trie
	BoutGauss = randn(Taille,Taille) + sqrt(-1) * randn(Taille,Taille);
	BoutGauss = MyFFT2( real( MyIFFT2(BoutGauss,Taille,Taille) ) ,Taille,Taille );

% Filtrage du bruit blanc
	SampleImage = MoyGauss + BoutGauss .* sqrt(Covariance);
