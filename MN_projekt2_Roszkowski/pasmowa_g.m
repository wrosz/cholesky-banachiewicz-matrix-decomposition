function [A] = pasmowa_g(a,b)
%PASMOWA_G zwraca macierz górnotrójkątną, gdzie na głównej
%przekątnej znajdują się elementy wektora a, na przekątnej powyżej- elementy
%wektora b. Pozostałe elementy są zerowe.
% a - n-elementowy wektor poziomy,
% b - (n-1)-elementowy wektor poziomy.

%sprawdzenie poprawności argumentów
if ~(size(a, 1)==1) || size(a,2) < 2
    error('a musi być wektorem poziomym długości co najmniej 2')
end
if ~(size(b, 1)==1) || ~(size(b,2)==size(a,2)-1)
    error('b musi być wektorem poziomym długości length(a)-1')
end

n = length(a);
A = diag(b);
A = [zeros(n-1,1) A];
A = [A; zeros(1, n)];
A = diag(a) + A;
end

