% CORONASIMULATE  Simulate coronagraph and Gerchberg-Saxton algorithm
%
% A simulation of a coronagraph and the Gerchberg-Saxton algorithm, in the
% context of NASA's Roman Space Telescope, developed to help teach ENCMP
% 100 Computer Programming for Engineers at the University of Alberta. The
% program saves data to a MAT file for subsequent evaluation.

%{
    Copyright (c) 2021, University of Alberta
    Electrical and Computer Engineering
    All rights reserved.

    Student name: Tazvik Ziauddin
    Student CCID: ziauddin
    Others:
    To avoid plagiarism, list the names of persons, other than a lecture
    instructor, whose code, words, ideas, or data were used. To avoid
    cheating, list the names of persons, other than a lab instructor, who
    provided substantial editorial or compositional assistance.

    After each name, including the student's, enter in parentheses an
    estimate of the person's contributions in percent. Without these
    numbers, adding to 100%, follow-up questions may be asked.

    For anonymous sources, enter code names in uppercase, e.g., SAURON,
    followed by percentages as above. Email a list of online sources
    (links suffice) to a teaching assistant before submission.
%}
clear
rng('default')

im = loadImage;
[im,Dphi] = opticalSystem(im,300);
images = gerchbergSaxton(im,20,Dphi);

frames = getFrames(images);
save frames frames

% im = loadImage returns an indexed image, im, of an exoplanet (2M1207b)
% orbiting a distant star. The image, a 2D matrix, is downloaded from a
% NASA website. It should be displayed with a grayscale colour map.
function im = loadImage
path = 'https://exoplanets.nasa.gov/system/resources/';
file = 'detail_files/300_26a_big-vlt-s.jpg';
im = imread(strcat(path,file));
im = rgb2gray(im);
end

%The optical system function returns the second arguement which is the true
%phase abberration in the pupil plane of the coronagraph 
function [im,Dphi] = opticalSystem(im,width)
im = occultCircle(im,width);
[IMa,IMp] = dft2(im);
imR = uint8(randi([0 255],size(im)));
[~,Dphi] = dft2(imR);
im = idft2(IMa,IMp-Dphi);
end

%Creating a black circle in the center of the image by getting the size of
%the matrix first then working from there
function im = occultCircle(im,w)
[r,c] = size(im);
x = (c-w)/2+((c+w)/2-(c-w)/2)/2;
y = (r-w)/2+((r+w)/2-(r-w)/2)/2;
im = insertShape(im,'FilledCircle',[x y w/2 ], 'Color', {'black'},...
   'Opacity', 0.95);
mask = rgb2gray(im);
end

% [IMa,IMp] = dft2(im) returns the amplitude, IMa, and phase, IMp, of the
% 2D discrete Fourier transform of an indexed image, im. The image, a 2D
% matrix, is expected to be of class 'uint8'. The phase is in degrees.
function [IMa,IMp] = dft2(im)
IM = fft2(im); 
IMa = abs(IM);
IMp = rad2deg(angle(IM));
end

% im = idft2(IMa,IMp) returns an indexed image, im, of class 'uint8' that
% is the inverse 2D discrete Fourier transform (DFT) of a 2D DFT specified
% by its amplitude, IMa, and phase, IMp. The phase must be in degrees.
function im = idft2(IMa,IMp)
IM = IMa.*complex(cosd(IMp),sind(IMp));
im = uint8(ifft2(IM,'symmetric'));
end

%This function makes an image variable using im,maxIters,and Dphi which has
%a value in an array from which it can be used in the next function to
%print the final result simulations
function [images,errors] = gerchbergSaxton(im,maxIters,Dphi,mask)
[IMa,IMp] = dft2(im);
images = cell(maxIters+1,1);
for k = 0:maxIters
    y = IMp + (Dphi/20)*k;
    fprintf('Iteration %d of %d\n',k,maxIters)
    im = idft2(IMa,y);
    images{k+1} = im;
    
end
end

%Finding the correct order to get the image in grayscale with no tickmarks
%in the axis and add a tittle and also add x and y labels
function frames = getFrames(images,errors)
numFrames = numel(images);
for k = 1:numFrames
    img = im2gray(images{k});
    imshow(img)
    hold on 
    title('Cornagraph Simulation')
    xlabel('Iteration')
    ylabel('Sum Square Error')
    
    hold off
    frames(k) = getframe(gcf);
end
close all
end
