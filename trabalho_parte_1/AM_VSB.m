%% Modulação e Demodulação de sinal usando o método VSB

%% Nomes

% Nome: Leonardo Amorim de Araújo Matrícula: 15/0039921
% Nome: Josiane de Sousa Alves    Matricula: 15/0038895

%% Sinal no tempo

close all;
clc;
clear all;

% Frequência de amostragem
Fs = 8*1024;

% Vetor de tempo
t = linspace(0,2,Fs);

% Sinal Analisado
%m = heaviside(t-0.1) - heaviside(t-0.5);
m = sin(2*pi*50*t);
%m = 10*(t-0.1).*(t>0.1).*(t<0.2) - 10*(t-0.3).*(t>0.2).*(t<0.4) ...
%+ 10*(t-0.5).*(t>0.4).*(t<0.5);
m_original = m;

%% Sinal na frequência

M = fft(m,Fs);
M_mag = abs(M);
f = (-length(M)/2:length(M)/2-1)*(Fs/2)/length(M);

%% Sinal modulado 

% Filtrando o sinal em f = 150 hz

fc = 150;
ordem = 4;
[b,a] = butter(ordem,fc/(Fs/2),'low');
m = filter(b,a,m);

% Multiplicando pela portadora
f_c = 300;
c = 2*cos(2*pi*f_c*t);
s = c.*m;


%% Sinal modulado na frequência

S = fft(s);
S_mag = abs(S);
S_mag = fftshift(S_mag);
ax4 = subplot(2,2,4);

% Gráficos 1

subplot(2,2,1);
plot(t,m);
axis([0 0.7 -2 2]);
xlabel('t(s)');
ylabel('m(t)');
title('Mensagem');
subplot(2,2,2);
plot(f,fftshift(M_mag));
xlabel('f(hz)');
ylabel('M(f)')
title('Espectro da mensagem')
axis([-150 150 0 500]);
subplot(2,2,3);
plot(t,s);
xlabel('t(s)');
ylabel('s(t)');
title('Sinal modulado');
axis([0 0.7 -2.5 2.5]);
subplot(2,2,4)
plot(f,S_mag);
axis([-400 400 0 500]);
xlabel('{\it f }(hz)');
ylabel('S(f)');
title('Espectro do sinal modulado');

%% Sinal passado pelo filtro passa-baixas para pegar somente o LSB 

[b,a] = butter(4,210/(Fs/2));
s = filter(b,a,s);
S = fft(s);
S_mag = abs(S);
S_mag = fftshift(S_mag);


%% Sinal demodulado

s_dem = s.*c;
S_dem = fft(s_dem);
S_dem_mag = abs(S_dem);
S_dem_mag = fftshift(S_dem_mag);

%% Filtrando o sinal em f_c = 150 hz na demodulação

fc = 150;
ordem = 4;
[b,a] = butter(ordem,fc/(Fs/2),'low');
s_recebido = filter(b,a,50*s_dem);

% Graficos dos resultados finais

figure;
subplot(2,1,1);
plot(f,S_mag);
%axis([260 340 0 15]);
grid on;
xlabel('f(hz)');
ylabel('S_{VSB}(f)')
title('Espectro do sinal após passar pelo filtro com f_c = 210 hz');
subplot(2,1,2);
plot(f,S_dem_mag);
axis([-750 750 0 15]);
xlabel('f(hz)');
ylabel('S_{VSB}');
title('Espectro do sinal após passar pela portadora no receptor');

figure;
subplot(1,2,1);
plot(t,m_original);
axis([0 0.7 -2 2]);
xlabel('t(s)');
ylabel('m(t)');
title('Sinal Original')
subplot(1,2,2);
plot(t,s_recebido);
axis([0 0.7 -2 2]);
xlabel('t(s)');
ylabel('m_T(s)')
title('Sinal Recebido')

