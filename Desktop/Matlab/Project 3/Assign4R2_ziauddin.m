function []=Assign4R2_ziauddin()
%Name: Tazvik Ziauddin
%CCID: ziauddin
%Others: 

%load data file, this data file needs to be in the same location as *.m
%file
load('Data_Year.mat');

%display a tile
%fprintf('ENCMP100 Assignment #4A Fitness Data Display\n');%For Rev 1
fprintf('ENCMP100 Assignment #4B Fitness Data Display\n');%For Rev 2

fprintf('Anaylsed by Student Name (ziauddin)\n'); % display who created program

for i=1:size(Data,2) %For Rev 1 31, For Rev 2 size(Data,2)
    Totals(i,:)=ConvertAndSum(Data(i));
end

GenPlots(Totals);
Stats=GenStats(Totals);
PrintData(Totals,Stats);

%save data as a *.mat file ... filename to be student name.mat
save('Tazvik Ziauddin.mat','Totals');

Monthly=ConvertAndSum_Monthly(Totals);
PrintMonthlyData(Monthly);
save('Tazvik Ziauddin_Monthly.mat','Monthly'); %save Monthly data as a *.mat file ... filename to be student name.mat
end

function [Totals] = ConvertAndSum(Data)
%Function ConvertAndSum: takes in a structure array Data, does some simple calculations and saves it into a new
%structure array called Totals.
Totals.Month = Data.Month;
Totals.Day=Data.Day;
Totals.Year = Data.Year;
Totals.Steps=Data.Steps;
Totals.Distance = Data.Steps*0.0006;
Totals.Floors=Data.Floors;
Totals.Sleep = ((Data.Sleep_Minutes)/60)+((Data.Nap_Minutes)/60)+...
    (Data.Sleep_Hours)+(Data.Nap_Hours);
Totals.RestingHR=Data.RestingHR;

end

function []=GenPlots(Totals)
%Function GenPlots: takes the values in a structure array called Totals and 
%plots 4 charts on one chart using subplot.
numberOfDays = linspace(1,400,365);
numberOfSteps = [Totals(:).Steps];
sleep = [Totals(:).Sleep];
numberOfFloors = [Totals(:).Floors];
restingHR = [Totals(:).RestingHR];

%figure plotted on first row first column
subplot(1,4,1)
plot(numberOfDays,sleep);
title('Sleep');
xlabel('Days');
ylabel('Hours');

%figure plotted on first row second column
subplot(1,4,2)
plot(numberOfDays,numberOfSteps);
title('Steps');
xlabel('Days');
ylabel('Steps');

%figure plotted on the first row third column
subplot(1,4,3)
plot(numberOfDays,numberOfFloors);
title('Floors Climbed');
xlabel('Days');
ylabel('Floors');

%figure plotted on the first row fourth column
subplot(1,4,4)
plot(numberOfDays,restingHR);
title('Resting HR');
xlabel('Days');
ylabel('Resting HR');


 end 

%}

function [Stats]=GenStats(Totals)
%Function:GenStats: generate stats like min., mean, and max. values of steps, sleep, floors climbed
%returns values in a array caled Stats.
Stats.Steps(1)= min([Totals.Sleep]);
Stats.Steps(2)= mean([Totals.Sleep]);
Stats.Steps(3)= max([Totals.Sleep]);
Stats.Sleep(1)= min([Totals.Steps]);
Stats.Sleep(2)= mean([Totals.Steps]);
Stats.Sleep(3)= max([Totals.Steps]);
Stats.Floors(1) = min([Totals.Floors]);
Stats.Floors(2) = mean([Totals.Floors]);
Stats.Floors(3) = max([Totals.Floors]);
Stats.totalSteps(1) = sum([Totals.Steps]);
Stats.totalDistance(1) = sum([Totals.Distance]);
Stats.totalFloors(1) = sum([Totals.Floors]);
Stats.totalSleepHours(1)= sum([Totals.Sleep]);

end

function []=PrintData(Totals,Stats)
%Function PrintData: prints a display from the data contained in the structure array Totals, and array Stats

%This prints the heading of each column
fprintf('\nMonth\tday\tYear\tsteps\tDistance\tFloors\t\tSleep\t\tResting HR\n');

%This loop prints the data for all 365 days
for i = 1:365
    fprintf('%s\t%d\t%d\t%d\t%.3f\t\t%d\t\t\t%.4f\t\t\t%d\n',Totals(i).Month,Totals(i).Day,Totals(i).Year,...
        Totals(i).Steps,Totals(i).Distance,Totals(i).Floors,Totals(i).Sleep,Totals(i).RestingHR);
end

%The following lines of code prints the total steps, distance, floors,
%sleep(hours)
fprintf('Totals\n  Steps  Distance  Floors  Sleep(hours)  \n %.0f  %.3f    %.0f     %.4f\n',...
    Stats.totalSteps(1),Stats.totalDistance(1),Stats.totalFloors(1),...
    Stats.totalSleepHours(1));

%This shows the Minimum values for sleep hours, steps and floors climbed
fprintf('Min Values: \n Sleep(Hours): %.2f Steps: %.2f Floors climbed: %.2f\n',...
    Stats.Steps(1),Stats.Sleep(1),Stats.Floors(1));
%This shows the Mean values for sleep hours, steps and floors climbed
fprintf('Mean/Average Values: \n Sleep(Hours): %.2f Steps: %.2f Floors climbed: %.2f\n',...
    Stats.Steps(2),Stats.Sleep(2),Stats.Floors(2));
%This shows the Maximum values for sleep hours, steps and floors climbed
fprintf('Max Values: \n Sleep(Hours): %.2f Steps: %.2f Floors climbed: %.2f\n',...
    Stats.Steps(3),Stats.Sleep(3),Stats.Floors(3));

end

function [Monthly]= ConvertAndSum_Monthly(TotalsDaily)
%Function ConvertAndSum_Monthly: converts the structure array Total (which should contain
%the daily totals for a year) to a monthly summary of results

%Sums all the steps for monthly average 
Monthly.Steps1 = sum([TotalsDaily(1:31).Steps]);
Monthly.Steps2 = sum([TotalsDaily(32:59).Steps]);
Monthly.Steps3 = sum([TotalsDaily(60:90).Steps]);
Monthly.Steps4 = sum([TotalsDaily(91:120).Steps]);
Monthly.Steps5 = sum([TotalsDaily(121:151).Steps]);
Monthly.Steps6 = sum([TotalsDaily(152:181).Steps]);
Monthly.Steps7 = sum([TotalsDaily(182:212).Steps]);
Monthly.Steps8 = sum([TotalsDaily(213:243).Steps]);
Monthly.Steps9 = sum([TotalsDaily(244:273).Steps]);
Monthly.Steps10 = sum([TotalsDaily(274:304).Steps]);
Monthly.Steps11 = sum([TotalsDaily(305:334).Steps]);
Monthly.Steps12 = sum([TotalsDaily(335:365).Steps]);
 
%Sums all the Distance for monthly average 
Monthly.Distance1 = sum([TotalsDaily(1:31).Distance]);
Monthly.Distance2 = sum([TotalsDaily(32:59).Distance]);
Monthly.Distance3 = sum([TotalsDaily(60:90).Distance]);
Monthly.Distance4 = sum([TotalsDaily(91:120).Distance]);
Monthly.Distance5 = sum([TotalsDaily(121:151).Distance]);
Monthly.Distance6 = sum([TotalsDaily(152:181).Distance]);
Monthly.Distance7 = sum([TotalsDaily(182:212).Distance]);
Monthly.Distance8 = sum([TotalsDaily(213:243).Distance]);
Monthly.Distance9 = sum([TotalsDaily(244:273).Distance]);
Monthly.Distance10 = sum([TotalsDaily(274:304).Distance]);
Monthly.Distance11 = sum([TotalsDaily(305:334).Distance]);
Monthly.Distance12 = sum([TotalsDaily(335:365).Distance]);
 
%Sums all the Floors for monthly average 
Monthly.Floors1 = sum([TotalsDaily(1:31).Floors]);
Monthly.Floors2 = sum([TotalsDaily(32:59).Floors]);
Monthly.Floors3 = sum([TotalsDaily(60:90).Floors]);
Monthly.Floors4 = sum([TotalsDaily(91:120).Floors]);
Monthly.Floors5 = sum([TotalsDaily(121:151).Floors]);
Monthly.Floors6 = sum([TotalsDaily(152:181).Floors]);
Monthly.Floors7 = sum([TotalsDaily(182:212).Floors]);
Monthly.Floors8 = sum([TotalsDaily(213:243).Floors]);
Monthly.Floors9 = sum([TotalsDaily(244:273).Floors]);
Monthly.Floors10 = sum([TotalsDaily(274:304).Floors]);
Monthly.Floors11 = sum([TotalsDaily(305:334).Floors]);
Monthly.Floors12 = sum([TotalsDaily(335:365).Floors]);
 
%Sums all the steps for monthly average 
Monthly.Sleep1 = sum([TotalsDaily(1:31).Sleep]);
Monthly.Sleep2 = sum([TotalsDaily(32:59).Sleep]);
Monthly.Sleep3 = sum([TotalsDaily(60:90).Sleep]);
Monthly.Sleep4 = sum([TotalsDaily(91:120).Sleep]);
Monthly.Sleep5 = sum([TotalsDaily(121:151).Sleep]);
Monthly.Sleep6 = sum([TotalsDaily(152:181).Sleep]);
Monthly.Sleep7 = sum([TotalsDaily(182:212).Sleep]);
Monthly.Sleep8 = sum([TotalsDaily(213:243).Sleep]);
Monthly.Sleep9 = sum([TotalsDaily(244:273).Sleep]);
Monthly.Sleep10 = sum([TotalsDaily(274:304).Sleep]);
Monthly.Sleep11 = sum([TotalsDaily(305:334).Sleep]);
Monthly.Sleep12 = sum([TotalsDaily(335:365).Sleep]);
 
%Sums all the RestingHR for monthly average 
Monthly.RestingHR1 = sum([TotalsDaily(1:31).RestingHR]);
Monthly.RestingHR2 = sum([TotalsDaily(32:59).RestingHR]);
Monthly.RestingHR3 = sum([TotalsDaily(60:90).RestingHR]);
Monthly.RestingHR4 = sum([TotalsDaily(91:120).RestingHR]);
Monthly.RestingHR5 = sum([TotalsDaily(121:151).RestingHR]);
Monthly.RestingHR6 = sum([TotalsDaily(152:181).RestingHR]);
Monthly.RestingHR7 = sum([TotalsDaily(182:212).RestingHR]);
Monthly.RestingHR8 = sum([TotalsDaily(213:243).RestingHR]);
Monthly.RestingHR9 = sum([TotalsDaily(244:273).RestingHR]);
Monthly.RestingHR10 = sum([TotalsDaily(274:304).RestingHR]);
Monthly.RestingHR11 = sum([TotalsDaily(305:334).RestingHR]);
Monthly.RestingHR12 = sum([TotalsDaily(335:365).RestingHR]);
 
%Turning the monthly averages of steps, Distance, Floors, Sleep and resting
%hours into a vector.
Monthly = [Monthly.Steps1,Monthly.Steps2,Monthly.Steps3,Monthly.Steps4,Monthly.Steps5,Monthly.Steps6,...
    Monthly.Steps7,Monthly.Steps8,Monthly.Steps9,Monthly.Steps10,Monthly.Steps11,Monthly.Steps12...
    Monthly.Distance1,Monthly.Distance2,Monthly.Distance3,Monthly.Distance4,Monthly.Distance5,Monthly.Distance6,...
    Monthly.Distance7,Monthly.Distance8,Monthly.Distance9,Monthly.Distance10,Monthly.Distance11,Monthly.Distance12...
    Monthly.Floors1,Monthly.Floors2,Monthly.Floors3,Monthly.Floors4,Monthly.Floors5,Monthly.Floors6,...
    Monthly.Floors7,Monthly.Floors8,Monthly.Floors9,Monthly.Floors10,Monthly.Floors11,Monthly.Floors12...
    Monthly.Sleep1,Monthly.Sleep2,Monthly.Sleep3,Monthly.Sleep4,Monthly.Sleep5,Monthly.Sleep6,...
    Monthly.Sleep7,Monthly.Sleep8,Monthly.Sleep9,Monthly.Sleep10,Monthly.Sleep11,Monthly.Sleep12...
    Monthly.RestingHR1,Monthly.RestingHR2,Monthly.RestingHR3,Monthly.RestingHR4,Monthly.RestingHR5,Monthly.RestingHR6,...
    Monthly.RestingHR7,Monthly.RestingHR8,Monthly.RestingHR9,Monthly.RestingHR10,Monthly.RestingHR11,Monthly.RestingHR12];
 

 
%This prints the heading of each column
 fprintf('\nMonth\tday\tYear\tsteps\tDistance\tFloors\t\tSleep\t\tResting HR\n');
 
 %This loop prints the Data for the monthly averages for the 12 months
for i = 1:12
   fprintf('\t%s\t%d\t%.3f\t\t%d\t\t%.4f\t%.2f\n','2018',...
       Monthly(i),Monthly(i+12), Monthly(i+24), Monthly(i+36),Monthly(i+48));
end
 

end


function []=PrintMonthlyData(TotalsMonth)
%Function PrintMonthlyData: display Monthly summarized results to the command window
 
end 