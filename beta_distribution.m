clear all
close all
clc

space = 0:0.001:1; % Create x axis to plot the figures in.
%theta = 0.5 % Unbiased coin, change probability for biasing coin. 


% Assume Prior that someone tells you out of the 20 times they have flipped
% the coin, the coin gave 11 times heads and 9 times tails. (frequentist
% assumption.. make it less than 1 for probabilistic assumptons)

beta_H = 11;
beta_T = 9 ;
prior = betapdf(space,beta_H,beta_T);

theta = 0.5; % probability of head (or 1 - tails)
% Now Create a sequence of 1000 tosses
sequence = binornd(1,theta,[1000,1]); % represents every flip of the coin

figure
% Lets Loop over and create a posterior pdf everytime we make an
% observation.
for i =1:length(sequence)
    
    alpha_H = sum(sequence(1:i)); % alpha_H is the number of heads thus far observed
    alpha_T = i - alpha_H; % i is the total observations so everything else is tails
    
    % likelihood is created as a binomial normalized by i
    likelihood = power(space,alpha_H/i).*power((1-space),alpha_T/i);
    [MLE, ind_mle] = max(likelihood); % MLE

    % posterior parameters.
    a=alpha_H+beta_H;
    b=alpha_T+beta_T;
    
    % Posterior is a beta distribution as explained.
    posterior = betapdf(space,a,b);
    [MAP, ind_map] = max(posterior); % MAP
   
    
    %Plot the posterior and the prior
    plot(space,prior,'Color','r','LineWidth',2);
    hold on;
    plot(space,likelihood,'Color','g','LineWidth',2);
    hold on;
    plot(space,posterior,'Color','b','LineWidth',2);
    hold on;
    legend({sprintf('Prior: beta_H = %1.2f beta_T = %1.2f',beta_H,beta_T),sprintf('Likelihood: alpha_H = %i alpha_T = %i',alpha_H,alpha_T),sprintf('Posterior: Mean = %1.2f and Variance = %1.2f',(a/(a+b)),(a*b)/((a+b)^2)*(a+b+1))},'Location','southoutside');
    title(sprintf('MAP = %1.4f at theta = %1.2f and MLE =%1.4f at theta = %1.2f',MAP,space(ind_map),MLE,space(ind_mle)));

    hold off;
    pause(0.01);
    
end

