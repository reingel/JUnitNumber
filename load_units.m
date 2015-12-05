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
mol = JUnitNumber('mol');
cd = JUnitNumber('cd');
rad = JUnitNumber('rad');
bit = JUnitNumber('bit');

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
day = 24*hour;

% frequency
Hz = 1/s;
kHz = 1000*Hz;
MHz = 1000*kHz;
GHz = 1000*MHz;

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

% electric charge
C = A*s;

% voltage
% electric potential difference
% electromotive force
V = J/C;

% electric capacitance
F = C/V;

% electric resistance
Ohm = V/A;

% electrical conductance
S = 1/Ohm;

% magnetic flux
Wb = V*s;

% magnetic field strength
T = Wb/m^2;

% inductance
H = Wb/A;

% battery capacity
Ah = A*hour;

% temperature


% percent
percent = JUnitNumber(1/100);

% data size
bits = bit;
kbit = 1000*bits;
kb = kbit;
Mbit = 1000*kbit;
Mb = Mbit;
Gbit = 1000*Mbit;
Gb = Gbit;
Tbit = 1000*Gbit;
Tb = Tbit;
byte = 8*bit;
bytes = byte;
B = bytes;
kB = 1000*B;
KB = 1024*bytes;
MB = 1024*KB;
GB = 1024*MB;
TB = 1024*GB;

% data speed
bps = bit/s;
kbps = kbit/s;
Mbps = Mbit/s;
Gbps = Gbit/s;
Tbps = Tbit/s;

% display message
disp('___ Units are loaded ___');

