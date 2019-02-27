clc;
clear all;
close all;

x=1:5  % input signal
[p q]=wavedec(x,3,'haar'); %wavelet decomposition suing inbuilt wavedec function
y=waverec(p,q,'haar') %wavelet reconstruction suing inbuilt waverec function

% function call
[s,l] = wavedecomposition(x,3) % calling the created function  to do decomposition
xrec = wavereconstruction(s,l) % calling the created function  to do decomposition