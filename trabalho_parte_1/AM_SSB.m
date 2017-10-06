%% Modulador e Demodulador SSB
%% Modula��o

%Nomes: Josiane de Sousa Alves 15/0038895
%       Leonardo Amorim de Ara�jo 15/0039921
close all;
clear all;
clc;
N = 1024;
fs = 2048;
ts = 1/fs;
t=(0:N-1)/fs;
fc = 300; %Frequ�ncia da Portadora
fm = 20;
A = 1;

%m = A*cos(2*pi*fm*t); %Mensagem
m = heaviside(t-0.1) - heaviside(t-0.6);
%mh = A*sin(2*pi*fm*t);
mh = hilbert(m);

usb = 0.5*(m.*cos(2*pi*fc*t) - mh.*sin(2*pi*fc*t)); %Expresss�o para usb
lsb = 0.5*(m.*cos(2*pi*fc*t) + mh.*sin(2*pi*fc*t)); %Express�o para lsb


USB = (2/N)*abs(fft(usb)); %Transformada de Fourier de usb
LSB = (2/N)*abs(fft(lsb)); %Transformada de Fourier de lsb

freq = fs * (0 : N/2) / N; 

close all;
figure(2)
subplot(221);
plot(10*t(1:200),real(usb(1:200)),'r');%Gr�fico de USB no dom�nio do tempo
title('USB - Dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal modulado');
axis([0 0.5 -1 1])
subplot(222)
plot(10*t(1:200),real(lsb(1:200)),'b');%Gr�fico de LSB no dom�nio do tempo
axis([0 0.5 -1 1])
title('LSB - Dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal modulado');

subplot(223);
plot(freq,USB(1:N/2+1))
title('Representa��o no dom�no da frequ�ncia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('USB');
axis([0 500 0 1.5]);
grid on;
subplot(224)
plot(freq,LSB(1:N/2+1)); %Gr�fico no LSB no dom�nio da frequ�ncia.
title('Representa��o no dom�nio da frequ�ncia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('LSB');
axis([0 500 0 1.5]);
grid on;
figure(4)
plot(freq,USB(1:N/2+1),freq,LSB(1:N/2+1));
axis([0 500 0 1.5]);
title('Representa��o no dom�nio da frequencia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('USB','LSB');


%% Demodula��o

md=usb.*cos(2*pi*fc*t)*2*2; 
[b,a]=butter(2,0.1);
mf=filter(b,a,md);
figure(1)
subplot (212)
plot(t,real(mf))
title('Sinal demodulado');
xlabel('Tempo'); ylabel('Sinal demodulado');
axis([0 0.2 -2 2]);

subplot (211)
plot(t,m);
title('Sinal original no dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal original');
axis([0 0.2 -2 2]);