%% Modulacao e Demodulação de sinal usando o metodo DSB+SC

%% Nomes

% Leonardo Amorim de Araújo Matrícula: 15/0039921
% Josiane de Sousa Alves    Matrícula: 15/0038895

%% Sinal no tempo

close all;
clc;
clear all;

Fs = 2048; % frequencia de amostragem
T = 1/Fs;  % periodo de amostragem
t = 0:T:1; % vetor de tempo
m = cos(2*pi*5*t) + sin(2*pi*10*t); % sinal analisado
%m = heaviside(t-0.1) - heaviside(t-0.6);
%m = (1/max(m))*m;


%% Modulação

f_c = 200; % Frequencia da portadora
c = cos(2*pi*f_c*t);
A = 1; % Amplitude da modulacao
s = A*m.*c; % Sinal modulado


%% Sinal na frequência

M = fft(m);
M_mag = abs(M/length(M));
f = (-length(M)/2:length(M)/2-1)*Fs/length(M);


%% Sinal modulado na frequência

S = fft(s);
S_mag = abs(S/length(S));

%% Gráficos

subplot(2,2,1);
plot(t,m);
axis([0 0.7 -1 2])
xlabel('t(s)');
ylabel('m(t)');
title('Mensagem');

subplot(2,2,2);
plot(f,fftshift(M_mag));
axis([-50 50 0 1])
xlabel('f(Hz)');
ylabel('M(f)');
title('Espectro da Mensagem')

subplot(2,2,3);
plot(t,s);
axis([0 0.7 -2 2])
xlabel('Time t(s)');
ylabel('s(t)');
title('Sinal modulado');

subplot(2,2,4);
plot(f,fftshift(S_mag));
axis([-250 250 0 0.5])
xlabel('f(Hz)');
ylabel('S(f)');
title('Espectro do sinal modulado');

%% Demodulação

% Multiplicaçao no receptor pela portadora

s = s.*(2*c);
S = fft(s);
S_mag = abs(S/length(S));

% Criando um filtro de butterworth de 20ª ordem e filtrando o sinal

fc = 300;
ordem = 20;
[b,a] = butter(ordem,fc/(Fs/2),'low'); 
m_filter = filter(b,a,s);

figure;
subplot(2,2,1);
plot(t,s);
axis([0 0.7 -1 3]);
xlabel('t(s)');
ylabel('s(t)');
title('Sinal modulado no receptor ');

subplot(2,2,2);
plot(f,fftshift(S_mag));
axis([-450 450 0 1])
xlabel('f(Hz)');
ylabel('S(f)');
title('Espectro do sinal modulado no receptor')

subplot(2,2,3);
plot(t,m);
axis([0 0.7 -1 3]);
xlabel('t(s)');
ylabel('m(t)');
title('Mensagem Original');

subplot(2,2,4);
plot(t,m_filter);
axis([0 0.7 -1 3]);
xlabel('t(s)');
ylabel('m_T(t)');
title('Mensagem Recebida');







