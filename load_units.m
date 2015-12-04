%
% Load Units
%
% Created by Soonkyu Jeong
% Creation Date : 2015.11.19
% Last Modified : 2015.11.19
%

% base units
% Length Mass Time ElectricCurrent ThermodynamicTemperature
% m      kg   s    A               K

clear % should be deleted in the future
clc

% fundamental units
m = JUnitNumber('m');
kg = JUnitNumber('kg');
s = JUnitNumber('s');
A = JUnitNumber('A');
K = JUnitNumber('K');
rad = JUnitNumber('rad');

% length
cm = 0.010*m;
mm = 0.001*m;
km = 1000*m;
inch = 0.0254*m;
feet = 12*inch;
yard = 3*feet;
mile = 1760*yard;

% area

% volume
liter = (10*cm)^3;

% mass
g = 0.001*kg;
ton = 1000*kg;

% time
sec = s;
msec = 0.001*s;
ms = msec;
usec = 1e-6*s;
minute = 60*s;
hour = 60*minute;

% speed
kph = km/hour;
mph = mile/hour;


% liter = 1e-3;
% uliter = 1e-6*liter;
% kW = 1000;
% kWh = kW*3600;
% kcal = 1/860*kWh; % 산업통상자원부고시 2014-218
% km = 1000;
% Nm = 1;
% kph = 1/3.6;
% rpm = 2*pi/60;
% percent = 1/100;
% Ah = 3600;
% bar = 1e5;
% N = 1;
% kN = 1000;
