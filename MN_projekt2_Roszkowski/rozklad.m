function [d, s] = rozklad(a, b)
%ROZKLAD zwraca wektory d, s, zadające górnotrójkątną macierz pasmową U,
%taką że UU'=A, gdzie A jest macierzą symetryczną trójdiagonalną zadaną
%przez wektory a, b.
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

% stworzenie wektorów d i s
d = zeros(1,n);
s = zeros(1,n-1);
if a(n) <= 0
    error('Macierz A nie jest dodatnio określona')
end
d(n) = sqrt(a(n));

% obliczenie pozostałych wyrazów wektora d i s ze związku rekurencyjnego
for k=(n-1):-1:1
    s(k) = b(k)/d(k+1);
        d_2 = a(k)-(s(k))^2;
    if d_2 <= 0
    error('Macierz A nie jest dodatnio określona')
    end
    d(k) = sqrt(d_2);
end

end

