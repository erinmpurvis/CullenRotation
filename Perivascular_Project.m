%% Perivascular Permeability Project
clc;clear;

%% Plot bar graph of percentage of permeabilized vessels
% Bars are group averages
% Error bars are SEM
g = categorical({'3 day 50 micron (n=2)', 'Same day 50 micron (n=4)','3 day 150 micron (n=2)','Same day 150 micron (n=4)'})
percentages = [ 0.415 0.658 6.45 7.13];
errhigh= [0.074 0.232 0.884 2.748];
errlow = [0.074 0.232 0.884 2.748];
bar(g,percentages)
hold on
er = errorbar(g,percentages,errlow,errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
ylabel('Percent')
title('Average Percentage of Permeabilized Vessels')

%% Box and whisker plot
% Below are the percentage of permeabilized vessels found within 50 and 150
% microns of the two groups, single- and three-day repetitive injury
% Each group has to have the same number of points in order to be able to
% plot on the same graph
% Therefore need to plot 3 day and single day separately 
threeday_50 = [0.31 0.52];
threeday_150 = [7.7 5.2];
singleday_50 = [0.58 0 0.75 1.3];
singleday_150 = [15.9 1.6 7.5 3.5];
% 3 day group plot
threeday_data = [0.31, 7.7; 0.52, 5.2]
boxplot(threeday_data,'Labels', {'Vessels with LY+ Cells within 50 microns','Vessels with LY+ Cells within 150 microns'})
ylabel('Percentage of Vessels Surrounded by LY+ Neurons')
title('3 Day Repetitive Injury Group')
% Single day group plot 
singleday_data = [0.58, 15.9; 0, 1.6; 0.75, 7.5; 1.3, 3.5]
boxplot(singleday_data, 'Labels', {'Vessels with LY+ Cells within 50 microns','Vessels with LY+ Cells within 150 microns'})
ylabel('Percentage of Vessels Surrounded by LY+ Neurons')
title('Same Day Repetitive Injury Group')
% The ends of the box are the upper and lower quartiles, so the box spans
% The interquartile range
% The medial is the line inside the box
% The whiskers outside of the box are the highest and lowest observations

%% Vessel Diameter
% Visualize vessel distribution
data_50micron = [31.555	21.247	20.501	28.72	25.373	32.506	56.672	18	54.214];
data_150micron = [28.708	27.958	34.955	32.118	40.297	56.22	42.514	35.443	18.227	36.605	25.165	46.629	87.586	17.26	58.726	49.735	34.338	28.813	19.525	40.814	31.555	15.617	32.42	47.96	40.27	63.659	45.685	39.797	21.247	22.938	23.259	24.478	32.344	33.534	35.037	27.828	62.702	22.976	78.681	40.011	46.932	73.072	37.077	29.306	47.03	20.207	25.366	25.628	25.503	28.316	31.057	22.047	24.827	22.05	15.993	23.879	66.269	28.78	30.32	29.322	59.778	28.912	36.243	23.145	30.704	45.519	35.382	38.847	25.6	20.772	43.971	32.591	27.084	36.354	41.579	22.791	25.827	15.042	15.747	24.149	36.231	45.6	23.7	26.501	30.001	49.252	44.968	29.559	19.552	26.764	18.87	35.892	26.271	33.524	32.78	19.374	25.022	27.689	21.13	24.598	23.206	17.8	36.38	36.666	50.132	20.501	28.72	33.921	23.462	80.237	22.477	36.845	21.513	22.938	78.915	23.456	14.88	25.373	23.74	27.023	26.797	48.934	28.984	32.157	19.597	23.933	57.76	62.468	24.89	35.4	32.506	62.877	31.635	56.672	19.943	18	36.038	54.214	38	36];
hist(data_50micron)
title ('Histogram of Vessel Diameters with at least 1 LY+ Cell within 50 microns');
xlabel ('Vessel Diameter');
ylabel ('Number of Vessels');
clf
hist(data_150micron)
title ('Histogram of Vessel Diameters with at least 1 LY+ Cell within 150 microns');
xlabel ('Vessel Diameter');
ylabel ('Number of Vessels');
% Make 4 total histograms: for all vessels, vessels with no surrounding
% permeability, vessels with LY+ cells within 150 microns, and vessels with
% LY+ cells within 50 microns 

%% Plot the cumulative distribution of each of the 4 different vessel
%%distributions
% The cumulative distribution function (cdf) is the probability that the
% variable takes a value less than or equal to x
% The horizontal axis is the domain for the given probability function, and
% the vertical axis is probability
% Differences between two distributions will get propagated along the
% cumulative distribution 
% Plotting cdf of multiple distributions on the same graph will show you at
% what point the distributions diverge
cdfplot(data_50micron)
hold on
cdfplot(data_150micron)
hold on
% Need to figure out how to import data from excel and plot the other two
% distributions on the same plot

%% Trying to figure out how to import data 
load Perivascular_Vessel_Diameter.xlsx
all_vessels = Perivascular_Vessel_Diameter(:,1);
hist(all_vessels)
% Use 'xlsread' instead of 'load'
xlsread Perivascular_Vessel_Diameter.xlsx;

%% Perform a ks test on the cumulative distributions
% Two-sample Kolmogorov-Smornov test
% h = kstest2(data set 1, data set 2)
% This test returns a decision for the null hypothesis that the data in two
% vectors are from the same continuous distribution 
% The alternative hypothesis is that the data are from two different
% distributions
% The result h is 1 if the test rejects the null hypothesis at the 5%
% significance level, and 0 otherwise 
% Can only compare 2 distributions at a time
h = kstest2 (data_50micron,data_150micron)
[h,p,k] = kstest2 (data_50micron,data_150micron)
% Value of 0, meaning that the null hypothesis is not rejected 
% This means that the data for 50 and 150 microns comes from the same
% distribution
% k is the value of the test statistic

%% Scatterplot of individual subject values
% x = number of vessels that had permeabilized neurons in the perivascular
% radius (1 value per subject)
% y = number of vessels that had permeabilized neurons in the
% extra-perivascular radius (1 value per subject)
a = [4 4 29 1 2 5];
b = [43 19 154 9 26 11];
scatter(a,b)
xlabel ('Number of Vessels with LY+ Cells within 50 microns');
ylabel ('Number of Vessels with LY+ Cells within 150 microns');
xlim ([0 160])
xticks ([0:20:160]);
yticks ([0:20:160]);
hold on
x = [0 160];
y = [0 160];
plot(x,y)
axis equal
axis square

