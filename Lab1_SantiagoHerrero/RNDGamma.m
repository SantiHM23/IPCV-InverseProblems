function SamplePrecision = RNDGamma(Alpha,Beta)	
% Tirage d'un �chantillon Gamma approch� par du Gauss
	%SamplePrecision = Alpha*Beta + sqrt( Alpha*(Beta*Beta) ) * randn;

% MODIF TBC 21/11/2018
	SamplePrecision = Alpha/Beta + sqrt( Alpha/(Beta*Beta) ) * randn;

