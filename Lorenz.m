% Параметри рівняння Лоренца
sigma = 10;
beta = 8/3;
rho = 28;

% Початкові умови
x0 = 0;
y0 = 1;
z0 = 20;

% Крок інтегрування
dt = 0.01;
tspan = 0:dt:100;

% Функція для рівнянь Лоренца
lorenz = @(t, xyz) [sigma * (xyz(2) - xyz(1)); ...
                    xyz(1) * (rho - xyz(3)) - xyz(2); ...
                    xyz(1) * xyz(2) - beta * xyz(3)];

% Розв'язок рівнянь Лоренца
[t, xyz] = ode45(lorenz, tspan, [x0, y0, z0]);

% Побудова аттрактора Лоренца
figure;
plot3(xyz(:,1), xyz(:,2), xyz(:,3));
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Хаотичний аттрактор Лоренца');
grid on;
