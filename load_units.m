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
uliter = 1e-6*liter;

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

% velocity
kph = km/hour;
mph = mile/hour;

% acceleration

% force
N = kg*m/s^2;
kN = 1000*N;

% energy
J = N*m;
kJ = 1000*J;
kWh = kJ/s*hour;
kcal = 1/860*kWh; % 산업통상자원부고시 2014-218

% power
W = J/s;
kW = 1000*W;

% torque
Nm = N*m*rad;

% pressure
Pa = N/m^2;
bar = 1e5*Pa;

% angle
deg = (pi/180)*rad;

% angular velocity
rpm = (2*pi*rad)/(60*s);

% angular acceleration

% battery capacity
Ah = A*hour;

% percent
percent = JUnitNumber(1/100);

disp('___ Units are loaded ___');

