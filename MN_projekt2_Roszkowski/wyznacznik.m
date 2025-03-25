function [y] = wyznacznik(a,b)
%WYZNACZNIK zwraca wyznacznik dodatnio określonej, symetrycznej macierzy trójdiagonalnej A
%zadanej przez wektory a i b. Korzysta on z funkcji [d, s]=rozklad(a, b),
%wymnażając elementy otrzymanego wektora d i podnosząc otrzymany iloczyn do kwadratu.
% a - n-elementowy wektor poziomy,
% b - (n-1)-elementowy wektor poziomy.
d = rozklad(a, b);
y = prod(d)^2;
end

