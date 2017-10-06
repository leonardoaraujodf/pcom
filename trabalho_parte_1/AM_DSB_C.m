%% Modulacao de sinal usando o metodo DSB+C

% Leonardo Amorim de Ara�jo Matr�cula: 15/0039921
% Josiane de Sousa Alves    Matr�cula: 15/0038895

%% Sinal no tempo

close all;
clc;
clear all;

Fs = 2048; % frequencia de amostragem
T = 1/Fs;  % periodo de amostragem
t = linspace(0,1,Fs); % vetor de tempo
%m = (sin(2*pi*5*(t-0.1)) + sin(2*pi*10*(t-0.1))).*(t>0.1); % sinal analisado
m = heaviside(t-0.1) - heaviside(t-0.6);
m = (1/max(m))*m;

%% Sinal na frequ�ncia

M = fft(m);
M_mag = abs(M/length(M));
f = (-length(M)/2:length(M)/2-1)*Fs/length(M);



%% Modula��o

f_c = 100; % Frequencia da portadora
c = cos(2*pi*f_c*t);
A = 1; % Amplitude da modulacao
u = 1; % Indice de modulacao
s = A*(1 + u*m).*c; % Sinal modulado


%% Sinal modulado na frequ�ncia

S = fft(s);
S_mag = abs(S/length(S));

subplot(2,2,1);
plot(t,m);
axis([0 0.7 -2 2])
xlabel('t(s)');
ylabel('m(t)');
title('Mensagem');

subplot(2,2,2);
plot(f,fftshift(M_mag));
axis([-12 12 0 0.3])
xlabel('f(Hz)');
ylabel('M(f)');
title('Espectro da Mensagem')

subplot(2,2,3);
plot(t,s);
axis([0 0.7 -3 3])
xlabel('t(s)');
ylabel('s(t)');
title('Sinal Modulado');

subplot(2,2,4);
plot(f,fftshift(S_mag));
axis([-150 150 0 0.6]);
xlabel('f(Hz)');
ylabel('S(f)');
title('Espectro do Sinal Modulado');

%% Demodula�ao

% Esta linha de codigo tem a mesma funcao de um super-diodo, ou seja, so
% ira deixar passar valores de $s > 0$.

s(s<0) = 0;

% Criando um filtro de Butterworth de 8� ordem

fc = 50; % Frequ�ncia de corte
ordem = 8;
[b,a] = butter(ordem,fc/(Fs/2),'low'); 
m_filter = filter(b,a,s);
m_filter = m_filter - mean(m_filter); % Arrancando o valor DC do sinal
m_filter = (1/max(m_filter))*m_filter; % Amplificando

figure;
subplot(3,1,1);
plot(t,s);
axis([0 0.7 -1 3]);
xlabel('t(s)');
ylabel('s(t)');
title('Sinal modulado depois de passar por um super-diodo');

subplot(3,1,2);
plot(t,m);
axis([0 0.7 -2 2]);
xlabel('t(s)');
ylabel('m(t)');
title('Sinal Original')

subplot(3,1,3);
plot(t,m_filter);
axis([0 0.7 -2 2]);
xlabel('t(s)');
ylabel('m_T(t)')
title('Sinal Recebido')
