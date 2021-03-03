%% Code Description
%
% This file contains two synthetic SCG signals for the following paper.
% Please cite the paper if you used this code:
%
% A. Taebi and H. A. Mansy, "Analysis of seismocardiographic signals using
% polynomial chirplet transform and smoothed pseudo Wigner-Ville
% distribution," 2017 IEEE Signal Processing in Medicine and Biology
% Symposium (SPMB), Philadelphia, PA, 2017, pp. 1-6, doi:
% 10.1109/SPMB.2017.8257022.
%
% Parameters:
%      Fs: sampling frequnecy
%       t: time vector
%   xtest: The synthtic signal to be analyzed
%
% Author: Amirtaha Taebi
% Biomedical Acoustics Research Laboratory
% University of Central Florida

%% Parameters

clear
close all
Fs = 320*1;                     % Sampling Freq
t = 0:1/Fs:4.0625-1/Fs;         % time vector
actual_SCG = 0;

%% Choosing the signal

sig = 'Synthetic_SCG_1';   % Synth SCG with cosine amplitude, 2 frequencies
% sig = 'Synthetic_SCG_2';   % with varying frequency

switch sig
    case 'Synthetic_SCG_1'
        % 2 sinusoids resembling SCG with cosine amplitude
        Fa = 7;
        Abaseline = 0;
        AmpRatio1 = 0.9;
        PhaseShift = pi/2;
        AmpRat2ndSCG = 0.7;
        Amp1 = Abaseline+.5*(1-cos(2*pi*Fa*t));
        t_freq1 = .498;

        % deifning amplitude of signal for different periods of time
        n_peaks = ceil(max(t)*Fa);
        for i = 1:4
           iPt1 = ceil((((2*i-1)*4)-i+1)*Fs/Fa+1);
           iPt2 = ceil((((2*i-1)*4)-i+4)*Fs/Fa+1);
           Amp1(iPt1:iPt2) = Abaseline;
        end

        for i = 1:4
            iPt1 = ceil((((2*i-1)*4)-i-2)*Fs/Fa+1);
            iPt2 = ceil((((2*i-1)*4)-i)*Fs/Fa+1);
            Amp1(iPt1:iPt2) = Abaseline;
        end

        for i = 1:4
            iPt1 = ceil((((2*i-1)*4)-i)*Fs/Fa+1);
            iPt2 = ceil((((2*i-1)*4)-i+1)*Fs/Fa+1);
            Amp1(iPt1:iPt2) = Amp1(iPt1:iPt2)*AmpRat2ndSCG;
        end

        F_test1 = 20.0;                          % 20 Hz component
        xtest1 = -Amp1 .* sin(2*pi*F_test1*t);
        F_test2 = 40.0;                          % 40 Hz component
        xtest2 = AmpRatio1 * Amp1 .* sin(2*pi*F_test2*t + PhaseShift);
        xtest = 20*(xtest1 + xtest2);                 % synthetic SCG

    case 'Synthetic_SCG_2'

        % 2 sinusoids resembling SCG with cosine amplitude and varying
        % frequency
        Fa = 7;
        Abaseline = 0.0;
        AmpRatio1 = 0.5;
        PhaseShift = 0;
        AmpRat2ndSCG = 0.7;
        Amp1 = Abaseline+.5*(1-cos(2*pi*Fa*t));
        t_freq1 = .498;

        % deifning amplitude of signal for different periods of time
        n_peaks = ceil(max(t)*Fa);
        for i = 1:4
           iPt1 = ceil((((2*i-1)*4)-i+1)*Fs/Fa+1);
           iPt2 = ceil((((2*i-1)*4)-i+4)*Fs/Fa+1);
           Amp1(iPt1:iPt2) = Abaseline;
        end

        for i = 1:4
            iPt1 = ceil((((2*i-1)*4)-i-2)*Fs/Fa+1);
            iPt2 = ceil((((2*i-1)*4)-i)*Fs/Fa+1);
           Amp1(iPt1:iPt2) = Abaseline;
        end

        for i = 1:4
            iPt1 = ceil((((2*i-1)*4)-i)*Fs/Fa+1);
            iPt2 = ceil((((2*i-1)*4)-i+1)*Fs/Fa+1);
            Amp1(iPt1:iPt2) = Amp1(iPt1:iPt2)*AmpRat2ndSCG;
        end

        F_test1 = 40;                          % 40 Hz sine wave
        xtest1 = -AmpRatio1 * Amp1 .* sin(2*pi*F_test1*t);
        

        t1 = 0:1/Fs:45/Fs;
        F_test2 = 531 * t1.^2 + 15.5 * t1 + 7; 
        IF2 = 531 * 3 * t1.^2 + 15.5 * 2 * t1 + 7; 
        f1 = zeros(1, 321);
        f2 = zeros(1, 91);
        f3 = zeros(1, 137);
        f4 = zeros(1, 476);
    
        xtest2 = sin(2*pi*F_test2.*t1 + PhaseShift);
        xtest2 = [f4, .5*xtest2, f2, xtest2, f3, .5*xtest2, f2, xtest2, f1]; 
        
        xtest2 =  Amp1 .* fliplr(xtest2);


        xtest = xtest1 + xtest2;               % synthetic SCG
        xtest(1:length(t)/4) = 0;
        xtest(3*length(t)/4:length(t)) = 0;
end