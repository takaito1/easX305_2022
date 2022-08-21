% safety first
close all;
clear all;

% add path to gsw_matlab if you haven't done so

%% The first step is to convert practical salinity to absolute salinity using gsw_SA_from_SP

% The following vertical profiles from the North Pacific are of 
% Practical Salinity SP and in-situ temperature t as a function of 
% pressure p 

SP = [ 34.5759  34.2870  34.5888  34.6589  34.6798  34.6910  34.6956 ]; 
t  = [ 19.5076   3.6302   1.9533   1.5661   1.4848   1.4989   1.5919 ]; 
p  = [       0     1010     2025     3045     4069     5098     6131 ];

SA = gsw_SA_from_SP(SP,p,-160,40); % calculate absolute salinity 
disp(['SA=',num2str(SA)])   % display the results

figure(1);
plot(SP,p,'ko-')   % plot SP as a function of pressure (depth)
hold on;
plot(SA,p,'rx-')   % plot SA as a function of pressure (depth) for visual comparison
hold off;
set(gca,'Ydir','reverse');
legend({'practical salinity' 'absolute salinity'})
xlabel('salinity')
ylabel('pressure, dbar');
set(gca,'fontsize',14);

%% The second step is to convert in-situ temperature, t, into Conservative Temperature, CT, using the function "gsw_CT_from_t"¶
figure(2);
CT = gsw_CT_from_t(SA,t,p);
disp(['CT=',num2str(CT)]);   % display the results
plot(t,p,'ko-');             % plot temperature as a function of pressure (depth)
hold on;
plot(CT,p,'rx-');            % plot conservative temperature as a function of pressure (depth) for visual comparison
hold off;
legend({'temperature' 'conservative temperature'})
xlabel('temperature')
ylabel('pressure, dbar')
set(gca,'Ydir','reverse');
set(gca,'fontsize',14);

% At this point the data has been converted into SA and CT, which are the TEOS-10 salinity and temperature variables.

% With these variables it is possible to compute the complete range of water column properties.

%% The first property to be demonstrated is density (rho) as a function of SA and CT. This is computed by using the function "gsw_rho".
figure(3);
rho = gsw_rho(SA,CT,p); % calculate density of seawater
disp(['rho=',num2str(rho)]); % display the results
plot(rho,p,'ko-');  % plot density as a function of pressure (depth)
xlabel('density, kg/m3')
ylabel('pressure, dbar')
set(gca,'Ydir','reverse');
set(gca,'fontsize',14);

%% Calculating the Conservative Temperature at which seawater freezes is done with the function "gsw_CT_freezing_poly"

% This programme allows the user to choose the amount of air which the water contains.

% When saturation_fraction is 0 the seawater contains no air, and when saturation_fraction is 1 the seawater is completely saturated with air.

% The example below is to have the seawater air free.
figure(4);
CT_freezing = gsw_CT_freezing_poly(SA,p,0); %calculate the freezing point
disp(['CT_freezing=',num2str(CT_freezing)]);     % display the results
plot(CT_freezing,p,'ko-');              % plot density as a function of pressure (depth)
xlabel('freezing temperature, deg C');
ylabel('pressure, dbar');
set(gca,'Ydir','reverse');
set(gca,'fontsize',14);
