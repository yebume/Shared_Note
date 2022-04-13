%%datas
A = 2;
T1 = 10;
T2 = 4;
T3 = 1;

W = tf(A, conv(conv([T1 1],[T2 1]),[T3 1]));
w0 = 5 / (T1+ T2 + T3);
xi = 0.7;
s1 = -xi*w0 + j * w0 *sqrt(1-xi^2);
s2 = conj(s1);
scinf = -3 * w0;
soinf = -5 * w0;

Ts = 0.2;
z1 = exp(s1*Ts);
z2 = exp(s2*Ts);
zoinf = exp(soinf*Ts);
zcinf = exp(scinf*Ts);
D = c2d(W, Ts, 'zoh');
B = D.num{1};
B = B(2:end);
A = D.den{1};

roots(B)
Bplus = 1;
Bminus = B;

l = 1;                                      %integrátorok száma
grBminus = length(Bminus) - 1;
grAm = 1 + grBminus;
grA = length(A) - 1;
grS = grA + 1 -1;
grR1v = grBminus;
grAo = grA + 1 - 1;
Am = poly([z1 z2 ones(1, grAm-2)*zcinf]);
Ao = poly(ones(1, grAo)*zoinf);             %megfigyelő polinom
Bmv = polyval(Am, 1) / polyval(Bminus, 1);
%Bmv = sum(Am, 1) / sum(Bminus, 1);
T = Bmv * Ao;
AA = conv(A, [1 -1]);                       %[1 -1] az integrátor
BB = Bminus;
CC = conv(Am, Ao);
