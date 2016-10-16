function  [density,pressure] = air_prop(x)

p_sealvl = 101.325; %sea level pressure in kPa
T0 = 288.15; % sea level standard temp in K
g = 9.806665; % gravity constant m/s^2
L = 0.0065; % K/m  lapse rate
R = 8.31447; % ideal gas constant J/(mol K)
M = 0.028644; %molar mass of dry air

pressure= p_sealvl*(1-(L*x)/T0).^((g*M)/(R*L)); % in kPa
T = T0-L*x;
density = (pressure*M)./(R*T).*(1000);
end
