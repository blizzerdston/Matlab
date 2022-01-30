
%{
 Copyright (c) 2020, Dileepan Joseph
 All rights reserved.
 Student name: Tazvik Ziauddin
 Student CCID: ziauddin
 Others: This assignment was 100% completed by me
 To avoid plagiarism, list the names of persons, whose code, ideas,
images, or data are used in any derivative work. To avoid cheating,
list the names of persons, other than your course or lab instructor who
provided compositional assistance.
 After each name, including the student's, enter in parentheses an
estimate of the person's contributions in percent. Without these
numbers, which add to 100%, follow-up questions will be asked.
 For an unknown person, e.g., an anonymous online source that should
be avoided, enter a code name in uppercase, e.g., SAURON, and email the
lab instructor prior to submission with the corresponding URL.
%}
clear; %deletes all the saved variables
clc; %clears the Command Window

%Ask the user to select a program of their choice
program = input('Select a program: 1. Arts; 2.Science; 3.Engineering:');

%Tuition fees for the Arts, Science and Engineering respectively
if program ==1
        tuition = 6000;
elseif program ==2
        tuition = 6500;
else
        tuition = 7000;     
end

%The following variables are for assigning starting balance, monthly
%contribution of $40 which will go up by 10 so initial value will be $50 in the loop
%,the annual interest rate, the monthly interest rate and by
%what percentage does tution increase each year
oldBalance = 2000;
monthlyContribution = 40;
annualInterestRate = 0.06;
monthlyInterestRate = annualInterestRate/12;
tuitionIncreaseRate = 0.0575;

newBalance = oldBalance;
newCost = tuition;

%calculate tuition fees for 22 years
for i = 1:22
    cost(i) = newCost;
    newCost = newCost + (newCost*tuitionIncreaseRate);
end

%calculate the tuition needed 
tuitionNeeded = sum(cost(19:22));

%This calculates the monthly savings required to meet the tuition
while newBalance < tuitionNeeded
    newBalance = oldBalance;
    monthlyContribution = monthlyContribution + 10;
    %calculate the savings for 18 years
    for i = 2:18*12
        newBalance = newBalance + (newBalance * monthlyInterestRate) +...
            monthlyContribution;
    end 
end

fprintf('The 4-year tuition fee is $ %4.2f\n', tuitionNeeded);
fprintf('You will need to save $ %4.2f each month to reach the goal\n', monthlyContribution);
