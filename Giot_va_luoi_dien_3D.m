clc; clear; close all;

% Kích thước mảng điện cực
gridSize = [10, 10];

% Danh sách các điện cực được bật theo thời gian
electrodeSequence = [3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9];

% Vị trí ban đầu của giọt
dropletPos = [2, 2];  % [row, col]
dropletRadius = 0.4;

% Số bước để di chuyển đến mỗi điện cực
numSteps = 30;
stepSize = 1;

% Thiết lập figure 3D
figure;
axis equal;
xlim([0 gridSize(2)]);
ylim([0 gridSize(1)]);
zlim([0 2]);
xlabel('X'); ylabel('Y'); zlabel('Z');
view(45, 30);
grid on;
hold on;

% Vẽ mảng điện cực dưới dạng hình hộp mỏng
for i = 1:gridSize(1)
    for j = 1:gridSize(2)
        [X,Y,Z] = meshgrid([j-1 j], [i-1 i], [0 0.05]);
        fill3([j-1 j j j-1], [i-1 i-1 i i], [0 0 0 0], [0.8 0.8 0.8]);
    end
end

% Khởi tạo hình cầu giọt nước
[sx, sy, sz] = sphere(30);  % mesh của hình cầu

% Animation
for t = 1:length(electrodeSequence)
    target = electrodeSequence(t, :);
    dir = target - dropletPos;
    dir = dir / norm(dir);

    for k = 1:numSteps
        % Cập nhật vị trí
        dropletPos = dropletPos + (stepSize/numSteps) * dir;

        % Xóa giọt cũ
        cla;

        % Vẽ điện cực
        for i = 1:gridSize(1)
            for j = 1:gridSize(2)
                color = [0.8 0.8 0.8];
                if i == target(1) && j == target(2)
                    color = [0 1 1];  % Điện cực bật: màu cyan
                end
                fill3([j-1 j j j-1], [i-1 i-1 i i], [0 0 0 0], color);
            end
        end

        % Vẽ giọt nước (hình cầu)
        cx = dropletPos(2) - 0.5;
        cy = dropletPos(1) - 0.5;
        cz = dropletRadius + 0.05;
        surf(cx + dropletRadius * sx, ...
             cy + dropletRadius * sy, ...
             cz + dropletRadius * sz, ...
             'FaceColor', 'blue', 'EdgeColor', 'none');

        % Hiệu ứng 3D đẹp hơn
        camlight; lighting gouraud; material shiny;
        title(sprintf('Step %d.%d', t, k));
        drawnow;
        pause(0.03);
    end
end
