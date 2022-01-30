% PERIHELION  Mercury's perihelion precession and general relativity
%
% In this lab assignment, a student completes a MATLAB program to test with
% data an accurate prediction of Einstein’s theory, namely the perihelion
% precession of Mercury. Mercury’s orbit around the Sun is not a stationary
% ellipse, as Newton’s theory predicts when there are no other bodies. With
% Einstein’s theory, the relative angle of Mercury’s perihelion (position
% nearest the Sun) varies by about 575.31 arcseconds per century.

%{
    Copyright (c) 2020, University of Alberta
    Electrical and Computer Engineering
    All rights reserved.

    Student name: Tazvik Ziauddin
    Student CCID: ziauddin
    Others: Golam Kibria Chowdhury (10%)(Helped me get started, He is not my 
    assigned Ta but still helped me during a long weekend when no Ta's were 
    answering. 

    To avoid plagiarism, list the names of persons, other than a lecture
    instructor, whose code, words, ideas, or data you used. To avoid
    cheating, list the names of persons, other than a lab instructor or
    teaching assistant (TA), who provided compositional assistance.

    After each name, including the student's, enter in parentheses an
    estimate of the person's contributions in percent. Without these
    numbers, adding to 100%, follow-up questions may be asked.

    For anonymous sources, enter code names in uppercase, e.g., SAURON,
    followed by percentages as above. Email a link to or a copy of the
    source to the lab instructor before the assignment is due.
%}
clear
close all
data = loaddata('horizons_results');
if isempty(data)
    error('File open failure')
end
data = locate(data); % All perihelia
data = select(data,25,{'Jan','Feb','Mar'});
data = refine(data, 'horizon_results');
makeplot(data,'horizons_results');
%savedata(data,'horizons_results');


function data = loaddata(filename)
%This function assigns a table to data that calculate and store value in it
%for the future. This function also opens filename and reads it from start
%till the end marked by the markers $$SOE to $$EOE. If the file opens then
%can make chnages to it otherwise it will show file open failure. 
%disp(filename)
filename = strcat(filename,'.txt');
fid = fopen(filename,'rt');
if fid ~= -1
    line = '';
    while ~feof(fid) && ~strcmp(line,'$$SOE')
        line = fgetl(fid);
    end
    data = cell(1000,3); % Preallocate
    num = 0;
    while ~feof(fid)
        line = fgetl(fid);
        if strcmp(line,'$$EOE') % Sentinel
            break % while
        end
        num = num+1;
        if size(data,1) < num
            disp(size(data,1))
            data{2*end,1} = []; % Allocate
        end
        data(num,:) = str2cell(line);
    end
    data = data(1:num,:); % Truncate
    fclose(fid);
    disp(num)
else
    data = {}; % File open failure
end
end

function cellrow = str2cell(eachLine)
%function str2cell converts string from horizon_results to a cell,then
%stores it to a variable called cellrow through the use of strsplit function
isplit = strsplit(eachLine,',');
%numdate carries the number date 
numdate = str2double(isplit{1});
%strdate is the date in string format
strdate = isplit{2}(7:17);
%x stroes x values by converting it into number
x = str2double (isplit{3});
%y stroes y values by converting it into number
y = str2double (isplit{4});
%z stroes z values by converting it into number
z = str2double (isplit{5});
%coordinates into table format
cellrow = {numdate,strdate,[x y z]};
end

function data = locate(data)
coord = cell2mat(data(:,3));
cov = coord'*coord; %Covariance
[map,val] = eig(cov,'vector');
[~,col] = min(val);
map(:,col) = [];%Minor axis
num = size(data,1);
for i = 1:num
    data{i,3} = data{i,3}*map;
end
end

function data = select(data,ystep,month)
%This function finds the years where the modulus division of year and ystep
%equal zero then it will compare month value of that year with three month value
%which is given and if it matches the function will collect the value and
%print it
ziauddin_size = length(data);
TOF = false(ziauddin_size);
for i = 1:ziauddin_size
    split = strsplit(data{i,2},('-'));
    year = str2double(split{1});
    ymod = mod(year,ystep);
    cmp_ziauddin = strcmpi(split{2},month);
    TOF (i) = (ymod==0) && any(cmp_ziauddin);
end
data = data(TOF,:);
end

function data = refine(data,filename)
%This function is going through the data array and picking up the dates
%that have a file in the same folder and then finding their perheilion and 
%putting it in the same folder
   num = size(data,1);
    iidata = cell(5, 3);
    for i = 1:num
     disp(filename)
    filename = strcat(strcat(filename, '_'), data{i, 2});
    idata = loaddata(filename);
   if isempty(idata)
      continue;
   end
   [~,~,precess] = arcsec(idata);
   vertcat(iidata, min(precess));
    disp(min(precess));
    end
   end 

function makeplot(data,filename)
%This fuction graphs the data from the above calculations
[numdate,strdate,precess] = arcsec(data);
p = polyfit(numdate,precess,1);
bestfit = polyval(p,numdate);
plot(numdate,precess,'bo',numdate,bestfit,'b-')
annotate(numdate,strdate,36525*p(1))
print('-dtiff',filename)
end

function [numdate,strdate,precess] = arcsec(data)
%This function is outputting three values which are numdate,strdate and its
%distance from the sun which is an array perhilion
numdate = cell2mat(data(:,1));
strdate = char(data{:,2});
num = size(data,1);
precess = zeros(num,1);
v = data{1,3}; % Reference position (2D/3D)
for i = 1:num
    u = data{i,3}; % Perihelion position (2D/3D)
    precess(i) = acosd((u*v')/sqrt((u*u')*(v*v')));
end
precess = 3600*precess; % arcsec
end

function annotate(numdate,strdate,slope)
%This function is just annotating the graph 
xticks(numdate)
xticklabels(strdate)
xtickangle(45) % (deg)
xlabel('Perihelion Date')
ylabel('Precession (arcsec)')
legend('Actual data','Best fit line','Location','SE')
line2 = sprintf(' %.2f arcsec/cent',slope);
label = {' Slope of best fit line:'; line2};
axis tight % Adjust plot limits to data extrema
text(min(xlim),max(ylim),label,'VerticalAlignment','top')
end
