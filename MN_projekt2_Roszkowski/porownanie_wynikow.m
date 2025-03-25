function [y1, y2] = porownanie_wynikow(dt, st)
%POROWNANIE_WYNIKOW zwraca tabelę porównującą wyniki otrzymane za pomocą
%funkcji rozklad, chol, wyznacznik i det, z poprawnymi danymi (które są
%wyznaczone przez argumenty dt i st).
%pierwsza tabela zawiera błędy bezwzględne, a druga - błędy względne.
%dt - macierz, której wiersze wyznaczają przekątną główną macierzy U, takiej że
%UU^T=A.
%st - macierz, której wiersze wyznaczają drugą przekątną macierzy U, takiej że
%UU^T=A.

% sprawdzenie poprawności argumentów
if size(dt,2) < 2
    error('dt musi być macierzą o co najmniej 2 kolumnach')
end
if ~(size(st, 1)==size(dt, 1)) || ~(size(st,2)==size(dt,2)-1)
    error('st musi być macierzą wymiarów size(dt,1)x(size(dt,2)-1)')
end

m = size(dt, 1); % liczba testów do wykonania
n = size(dt, 2); % rozmiar macierzy A
blad_rozklad = zeros(1,m);
blad_chol = zeros(1,m);
blad_wyznacznik = zeros(1,m);
blad_det = zeros(1,m);
blad_rozklad_wzgl = zeros(1,m);
blad_chol_wzgl = zeros(1,m);
blad_wyznacznik_wzgl = zeros(1,m);
blad_det_wzgl = zeros(1,m);

for k = 1:m
    U_poprawna = pasmowa_g(dt(k,:),st(k,:));
    L_poprawna = pasmowa_g(dt(k,n:-1:1),st(k,n-1:-1:1))';
    det_poprawny = prod(dt(k,:))^2;
    
    A = U_poprawna*U_poprawna';
    a = diag(A)';
    b = diag(A, 1)';
    A_odwrocona = pasmowa_s(a(n:-1:1), b((n-1):-1:1));

    [d, s] = rozklad(a, b);
    U_wynik = pasmowa_g(d, s);
    wyznacznik_wynik = wyznacznik(a, b);
    det_wynik = det(A);
    try
        L_wynik = chol(A_odwrocona)';
    catch
        L_wynik = NaN;
    end

    blad_rozklad(k) = norm(U_poprawna - U_wynik);
    blad_chol(k) = norm(L_poprawna - L_wynik);
    blad_wyznacznik(k) = abs(wyznacznik_wynik - det_poprawny);
    blad_det(k) = abs(det_wynik - det_poprawny);
    blad_rozklad_wzgl(k) = blad_rozklad(k) / norm(U_poprawna);
    blad_chol_wzgl(k) = blad_chol(k) / norm(L_poprawna);
    blad_wyznacznik_wzgl(k) = blad_wyznacznik(k) / abs(det_poprawny);
    blad_det_wzgl(k) = blad_det(k) / abs(det_poprawny);

end

colnames = {'rozklad(a, b)', 'chol(A_odwrocona)', 'wyznacznik(a, b)', 'det(A)'};
% błędy bezwzględne:
y1 = table(blad_rozklad', blad_chol', blad_wyznacznik', blad_det', 'VariableNames', colnames);
% błędy względne:
y2 = table(blad_rozklad_wzgl', blad_chol_wzgl', blad_wyznacznik_wzgl', blad_det_wzgl', 'VariableNames', colnames);

end