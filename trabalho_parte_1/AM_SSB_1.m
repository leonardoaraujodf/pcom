%%Modulador e Demodulador SSB
%Nomes: Josiane de Sousa Alves 15/0038895
%       Leonardo Amorim de Ara�jo 15/0039921

Fs = 2048;
t=linspace(0,1,Fs);
fc = 300; %Frequ�ncia da Portadora
fm = 20;
A = 1;

m = A*cos(2*pi*fm*t); %Mensagem

mh = A*sin(2*pi*fm*t); %hilbert transform

usb = m.*cos(2*pi*fc*t) - mh.*sin(2*pi*fc*t); %Expresss�o para usb
lsb = m.*cos(2*pi*fc*t) + mh.*sin(2*pi*fc*t); %Express�o para lsb

USB = abs(fft(usb)); %Transformada de Fourier de usb
LSB = abs(fft(lsb)); %Transformada de Fourier de lsb

freq = (-length(USB)/2:length(USB)/2-1)*(fs/2)/length(USB); 

close all;
figure(2)
subplot(2,2,1);
plot(t,real(usb),'r');%Gr�fico de USB no dom�nio do tempo
title('USB - Dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal modulado');
axis([0 0.2 -2 2]);

subplot(2,2,2)
plot(t,real(lsb),'b');%Gr�fico de LSB no dom�nio do tempo
title('LSB - Dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal modulado');
axis([0 0.2 -2 2]);

subplot(2,2,3);
plot(freq,fftshift(USB));
title('Representa��o no dom�no da frequ�ncia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('USB');
axis([-300 300 0 300]);

subplot(2,2,4)
plot(freq,fftshift(LSB)); %Gr�fico no LSB no dom�nio da frequ�ncia.
title('Representa��o no dom�nio da frequ�ncia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('LSB');
axis([-300 300 0 300]);

figure;
plot(freq,USB,freq,LSB);
axis([-500 500 0 300]);
title('Representa��o no dom�nio da frequencia');
xlabel('Frequencia(Hz)'); ylabel('Magnitude do espectro');
legend('USB','LSB');


%Demodula��o:

md=usb.*cos(2*pi*fc*t)*2; 
[b,a]=butter(2,0.1);
mf=filter(b,a,md);
figure;
subplot (212)
plot(t,real(mf))
title('Sinal demodulado');
xlabel('Tempo'); ylabel('Sinal demodulado');
subplot (211)
plot(t,m);
title('Sinal original no dom�nio do tempo');
xlabel('Tempo'); ylabel('Sinal original');
