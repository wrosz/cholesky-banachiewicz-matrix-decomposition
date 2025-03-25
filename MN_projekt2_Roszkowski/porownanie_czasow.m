function [y] = porownanie_czasow(dt, st)
%POROWNANIE_CZASOW zwraca tabelę porównującą czasy rozkładu macierzy A na
%macierze trójkątne funkcją chol(A) oraz funkcją rozklad(a, b) oraz czasy
%obliczenia wyznacznika macierzy A funkcjami wyznacznik(a,b) oraz det(A).
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
t_rozklad = zeros(1,m);
t_chol_ta_sama = zeros(1,m);
t_chol_odwrocona = zeros(1,m);
t_wyznacznik = zeros(1,m);
t_det = zeros(1,m);

for k = 1:m
    %stworzenie macierzy A (w ten sposób upewniamy się, że jest dodatnio
    %określona, czyli rozkłady Cholesky'ego-Banachiewicza istnieją)
    Ut = pasmowa_g(dt(k,:), st(k,:));
    At = Ut*Ut';
    a = diag(At)';
    b = diag(At, 1)';
    
    % porównanie czasów rozkładu A = UU^T oraz A = LL^T
    tic;
    rozklad(a, b);
    t_rozklad(k) = toc;

    tic;
    A = pasmowa_s(a, b);
    chol(A);
    t_chol_ta_sama(k) = toc;

    a = a(n:-1:1);
    b = b((n-1):-1:1);
    tic;
    A_odwrocona = pasmowa_s(a, b);
    chol(A_odwrocona);
    t_chol_odwrocona(k) = toc;

    % porównanie czasów obliczenia wyznacznika macierzy UU'
    tic;
    det(At);
    t_det(k) = toc;
    
    tic;
    wyznacznik(a, b);
    t_wyznacznik(k) = toc;
    
end

colnames = ["A = UU^T", "A = LL^T", "A' = LL^T", "wyznacznik(a, b)", "det(A)"];
y = table(t_rozklad', t_chol_ta_sama', t_chol_odwrocona', t_wyznacznik', t_det', 'VariableNames', colnames);
end