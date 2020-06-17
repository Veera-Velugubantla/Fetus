%% clearing comands %%
clc;
clear all;
close all;
load foetal_ecg.dat;         % loading the given signal
signal=foetal_ecg.';         % Taking transpose of the given fetal_ecg 
abdomin_signals=signal(2:6,:);% seperating the abdomin signals from mixed input signal
thoracic_signals=signal(7:9,:);% seperating the thoracic signals from mixed input signal
time=signal(1,:);              % seperating the time signal 
abdomin_avg=(sum(abdomin_signals))/5;% averaging the abdomin signals
thoracic_avg=(sum(thoracic_signals))/3;% averaging the thoracic signals

%%% plotting the both (mother+fetus) and mother signals
figure,subplot(2,1,1),
plot(time,abdomin_avg,'g');
title('Input:mother+foetus signal');
xlabel('Time[s]'); 
ylabel('Amplitude[volts]');
subplot(2,1,2),plot(time,thoracic_avg,'k');
title('Mother signal)');
xlabel('Time[sec]');
ylabel('Amplitude[volts]');

%lms
order=10; %order of filter
mu=0.0000001;% Step size
x1=convm(thoracic_signals(1,:),order); 
x2=convm(thoracic_signals(2,:),order);
x3=convm(thoracic_signals(3,:),order);
[A,E,y] = lmssource1(x1,x2,x3,abdomin_avg,mu,order); %calling LMS function

%nlms
beta= 0.005; %normalized step size
[An,En,yn] = nlmsmiso(x1,x2,x3,abdomin_avg,beta,order);%calling NLMS function


%LLMS
gamma=0.003;%leaky coefficient
mu=0.0000004;%step size

[Wl,El,yl] = llmshmiso(x1,x2,x3,abdomin_avg,mu,gamma,order);%calling LLMS function


%%% plotting fetus ECG for LMS,NLMS,LLMS algorithms
figure,subplot(2,1,1),plot(time,E(1:2500),'--r');
hold on;
plot(time,En(1:2500),'--b');
plot(time,El(1:2500),'--g');
title('Fetus ecg');
xlabel('Time [s]');
ylabel('Voltage mv-voltage');
hold off;
legend('MISO-LMS','MISO-NLMS','MISO-LLMS');
%%% ploting the Filtered output for LMS,NLMS,LLMS algorithms 
subplot(2,1,2),plot(time,y(1:2500),'--r');
title('Filtered output');
xlabel('Time [s]');
ylabel('Voltage mv-voltage');
hold on;
plot(time,yn(1:2500),'--b');
plot(time,yl(1:2500),'--g');
hold off;
legend('MISO-LMS','MISO-NLMS','MISO-LLMS');


