function [A] = pasmowa_s(a, b)
%PASMOWA_S zwraca symetryczną macierz trójdiagonalną, gdzie na głównej
%przekątnej znajdują się elementy wektora a, na przekątnej powyżej i poniżej - elementy
%wektora b.
% a - n-elementowy wektor poziomy,
% b - (n-1)-elementowy wektor poziomy.
A = pasmowa_g(a/2, b) + pasmowa_g(a/2,b)';
end

