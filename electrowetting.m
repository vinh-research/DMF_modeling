clc; clear; close all;

% Thông số vật lý
epsilon0 = 8.85e-12;     % F/m
epsilon_r = 2.5;         % vật liệu điện môi
gamma = 0.072;           % N/m
d = 1e-6;                % m
theta0 = deg2rad(110);   % góc tiếp xúc ban đầu

% Các mức điện áp
voltages = linspace(0, 150, 100);  % V

% Tạo hình cầu đơn vị
[sx, sy, sz] = sphere(50);
r = 1;


% Thiết lập figure
fig = figure('Position',[100 100 600 500]);
axis equal; axis off;
view(3); camlight; lighting gouraud;


figure;
for i = 1:length(voltages)
    V = voltages(i);
    cosThetaV = cos(theta0) + (epsilon0 * epsilon_r * V^2) / (2 * gamma * d);
    cosThetaV = min(cosThetaV, 1);  % tránh lỗi
    thetaV = acos(cosThetaV);
    
    % Tính tỷ lệ chiều cao giọt theo góc tiếp xúc
    heightFactor = tan(thetaV);  % càng nhỏ thì giọt càng dẹt

    
    cla;
    surf(sx*r, sy*r, sz*r*heightFactor, 'FaceColor','blue','EdgeColor','none');
    title(sprintf('V = %.1f V | θ = %.1f°', V, rad2deg(thetaV)), 'FontSize', 14);
    drawnow;
    pause(0.05);  % tốc độ hoạt ảnh
end

