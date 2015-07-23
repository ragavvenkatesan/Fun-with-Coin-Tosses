clear all
close all
clc

space = 0:0.001:1; % Create x axis to plot the figures in.
%theta = 0.5 % Unbiased coin, change probability for biasing coin.


% Assume Prior that someone tells you out of the 20 times they have flipped
% the coin, the coin gave 11 times heads and 9 times tails. (frequentist assumption)
beta_H = 2 ;
beta_T = 2 ;
prior = betapdf(space,beta_H,beta_T);

% Now Create a sequence of 1000 tosses
sequence = binornd(1,0.5,[1000,1]);

figure
% Lets Loop over and create a posterior pdf everytime we make an
% observation.


alpha_H = 18;
alpha_T = 28;

likelihood = power(space,alpha_H/(alpha_H+alpha_T)).*power((1-space),alpha_T/(alpha_H+alpha_T));
[MLE, ind_mle] = max(likelihood); % MLE

posterior = betapdf(space,alpha_H+beta_H,alpha_T+beta_T);
a=alpha_H+beta_H;
b=alpha_T+beta_T;
[MAP, ind_map] = max(posterior); % MAP


%Plot the posterior and the prior
plot(space,prior,'Color','r','LineWidth',2);
hold on;
plot(space,likelihood,'Color','g','LineWidth',2);
hold on;
plot(space,posterior,'Color','b','LineWidth',2);
hold on;
legend({sprintf('Prior estimate of probability of head : beta_H = %1.2f beta_T = %1.2f',beta_H,beta_T),sprintf('Likelihood of probability of head: alpha_H = %i alpha_T = %i',alpha_H,alpha_T),sprintf('Posterior of probability of head: Mean = %1.2f and Variance = %1.2f',(a/(a+b)),(a*b)/((a+b)^2)*(a+b+1))},'Location','southoutside');
hold off;
title(sprintf('MAP = %1.4f at theta = %1.2f and MLE =%1.4f at theta = %1.2f',MAP,space(ind_map),MLE,space(ind_mle)));
