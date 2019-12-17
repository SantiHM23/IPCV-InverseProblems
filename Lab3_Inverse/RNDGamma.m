function SamplePrecision = RNDGamma(Alpha,Beta)	

% Tirage d'un échantillon Gamma approché par du Gauss (JFG+TBC)
	SamplePrecision = Alpha/Beta + sqrt( Alpha/(Beta*Beta) ) * randn;
