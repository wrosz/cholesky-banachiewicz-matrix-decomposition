rng(1);

%% Macierz wyznaczona przez d = [1 2 3 4 5], s = [-1 -2 -3 -4]
d = [1 2 3 4 5]; s = [-1 -2 -3 -4];
U = pasmowa_g(d, s)
A = U*U'
a = diag(A)';
b = diag(A, 1)';
A_odwrocona = pasmowa_s(a(5:-1:1), b(4:-1:1));
L = chol(A_odwrocona)'
wyznacznik_funkcja_det = det(A)
wyznacznik_funkcja_wyznacznik = wyznacznik(a,b)
wyznacznik_iloczyn_wyrazow_d = prod(d)^2

%% Macierz 10x10 o współczynnikach całkowitych z przedziału [1, 10]

dt = randi(10, 10, 10)
st = randi(10, 10, 9);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

%% Macierz 10x10 o współczynnikach na przedziale (0, 10)
dt = 5*rand([10, 10]) + 5;
st = 5*rand([10, 9]) + 5;
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

%% Macierze 10x10 o dużych współczynnikach całkowitych

disp('[9*10^6,10^7]')
dt = randi([9*10^6,10^7], 10, 10);
st = randi([9*10^6,10^7], 10, 9);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

disp('[9*10^7,10^8]')
dt = randi([9*10^7,10^8], 10, 10);
st = randi([9*10^7,10^8], 10, 9);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

disp('[9*10^14,10^15]')
dt = randi([9*10^14,10^15], 10, 10);
st = randi([9*10^14,10^15], 10, 9);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

%% Macierze "ledwo" dodatnio określone
d = 0.005*rand([1, 10]) + 0.005; s = 1:9;
U = pasmowa_g(d, s);
A = U*U';
a = diag(A)';
b = diag(A, 1)';
A_odwrocona = pasmowa_s(a(10:-1:1), b(9:-1:1));
try
    rozklad(a,b)
catch e
    disp(e.message);
end
try
    chol(A_odwrocona)
catch e
    disp(e.message);
end
eig(A)

%% Macierze 1000x1000 o współczynnikach na przedziale (-1, 1)
dt = 0.5*rand([10, 1000]) + 0.5; % współczynniki na przekątnej głównej muszą być dodatnie,
                                 %  aby macierz A była dodatnio określona
st = rand([10, 999]);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny

%% Macierze 5000x5000 o współczynnikach na przedziale (-1, 1)
dt = 0.5*rand([5, 5000]) + 0.5; % współczynniki na przekątnej głównej muszą być dodatnie,
                                 %  aby macierz A była dodatnio określona
st = rand([5, 4999]);
czasy = porownanie_czasow(dt, st)
[blad_bezwzgledny, blad_wzgledny] = porownanie_wynikow(dt, st);
blad_bezwzgledny
blad_wzgledny
