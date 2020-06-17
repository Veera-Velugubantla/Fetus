%% clearing comands %%
clc;
clear all;
close all;
load foetal_ecg.dat;        % loading the given signal
signal=foetal_ecg.';        % Taking transpose of the given fetal_ecg 
abdomin_signals=signal(2:6,:);% seperating the abdomin signals from mixed input signal
thoracic_signals=signal(7:9,:);% seperating the thoracic signals from mixed input signal
time=signal(1,:);               % seperating the time signal

%%% plotting the abdomin signals
figure,
for i=1:2
subplot(2,1,i),plot(time,abdomin_signals(i,:)); 
title(['Abdomin signal ',num2str(i)]);
xlabel('Time [s]');
ylabel('Amplitude[volts]');
end
figure,
for i=3:4
subplot(2,1,i-2),plot(time,abdomin_signals(i,:)); 
title(['Abdomin signal ',num2str(i)]);
xlabel('Time [s]');
ylabel('Amplitude[volts]');
end
figure,
plot(time,abdomin_signals(5,:));
title('Abdomin signal 5');
xlabel('Time [s]');
ylabel('Amplitude[volts]');

%%% plotting the thoracic signals
figure,
for i=1:3
subplot(3,1,i),plot(time,thoracic_signals(i,:),'r');
title(['thoracic signal ',num2str(i)]);
xlabel('Time [s]');
ylabel('Amplitude[volts]');
end
% averaging of abdomin signals
abdomin_avg=(sum(abdomin_signals))/5;
% averaging of thoracic signals
thoracic_avg=(sum(thoracic_signals))/3;

%%% plotting the both (mother+fetus) and mother signals
figure,subplot(2,1,1),plot(time,abdomin_avg,'g');
title('Input:Average of abdominal signals(mother+fetus)');
xlabel('time [s]');
ylabel('amplitude[volts]');
subplot(2,1,2),plot(time,thoracic_avg,'k');
title('Reference:Average of thoracic signals(Mother)');
xlabel('Time[sec]');
ylabel('Amplitude[volts]');

%%
%lms filter
order=12; %order of filter
mu=0.000001;  % Step size
X=convm(thoracic_avg,order); 
[A,E,y] = lmssource(X,abdomin_avg,mu,order); %calling LMS function



%%
%nlms filter
beta=0.009; %normalized step size
[An,En,yn] = nlms(X,abdomin_avg,beta,order);%calling NLMS function

%%
%llms

gamma=0.003; %leaky coefficient
mu=0.0000004; %step size
[Al,El,yl] = llmsh(thoracic_avg,abdomin_avg,mu,gamma,order);%calling LLMS function

%%
%%% plotting fetus ECG for LMS,NLMS,LLMS algorithms
figure,subplot(2,1,1),plot(time,E(1:2500),'--r');
hold on;
plot(time,En(1:2500),'--b');
plot(time,El(1:2500),'--g');
title('Fetus ecg');
xlabel('Time [s]');
ylabel('Amplitude[volts]');
hold off;
legend('SISO-LMS','SISO-NLMS','SISO-LLMS');
%%% ploting the Filtered output for LMS,NLMS,LLMS algorithms
subplot(2,1,2),plot(time,y(1:2500),'--r');
title('Filtered output');
xlabel('Time [s]');
ylabel('Amplitude[volts]');
hold on;
plot(time,yn(1:2500),'--b');
plot(time,yl(1:2500),'--g');
hold off;
legend('SISO-LMS','SISO-NLMS','SISO-LLMS');




