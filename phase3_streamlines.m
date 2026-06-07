% VIRTUAL WIND TUNNEL: PHASE 3
% Flow Streamlines around an Airfoil (Joukowski Transformation)
clear; clc; close all;

disp('Generating Flow Streamlines...');

% 1. Flow Parameters
U = 1;            % Wind velocity
alpha = 4*pi/180; % Angle of attack (4 degrees)
Gamma = 2.5;      % Circulation strength (this creates the lift)

% 2. Cylinder parameters (we will warp this into our airfoil)
R = 1.1;          % Cylinder radius
cx = -0.1;        % X-offset (controls the camber/curve)
cy = 0.1;         % Y-offset (controls the thickness)

% 3. Create the mathematical wind grid
[X, Y] = meshgrid(linspace(-4, 4, 200), linspace(-3, 3, 200));
Z = X + 1i*Y;

% 4. Calculate the fluid flow around the initial cylinder
Z_cyl = Z - (cx + 1i*cy);
W = U * (Z_cyl.*exp(-1i*alpha) + (R^2)./(Z_cyl.*exp(-1i*alpha))) - 1i*(Gamma/(2*pi))*log(Z_cyl);

% 5. The Joukowski Transformation (Crushing the cylinder into a wing!)
Z_airfoil = Z + 1./Z;

% 6. Extract the Streamlines 
Psi = imag(W);

% Clean up the flow lines inside the solid wing
inside = abs(Z_cyl) < R;
Psi(inside) = NaN; 

% 7. Plotting the Wind Tunnel Result
figure('Name', 'Flow Streamlines', 'NumberTitle', 'off');
hold on; axis equal;

% Draw the wind streamlines
contour(real(Z_airfoil), imag(Z_airfoil), Psi, 60, 'b', 'LineWidth', 1);

% Draw the solid wing surface
theta = linspace(0, 2*pi, 100);
z_surf = (cx + 1i*cy) + R*exp(1i*theta);
airfoil_surf = z_surf + 1./z_surf;
fill(real(airfoil_surf), imag(airfoil_surf), [0.8 0.8 0.8], 'EdgeColor', 'k', 'LineWidth', 1.5);

title('Wind Tunnel Flow Streamlines (\alpha = 4°)');
xlabel('X Position');
ylabel('Y Position');
axis([-3 3 -2 2]);
grid on;

disp('Streamline visualization complete!');
