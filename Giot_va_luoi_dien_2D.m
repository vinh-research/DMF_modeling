% Số bước nhỏ để đi từ vị trí hiện tại đến mục tiêu
numSteps = 20;  % Tăng số bước => chậm hơn

for t = 1:length(electrodeSequence)
    % Bật 1 điện cực tại thời điểm t
    electrodeMatrix(:) = 0;
    target = electrodeSequence(t, :);
    electrodeMatrix(target(1), target(2)) = 1;
    
    % Tính hướng di chuyển của giọt về phía điện cực bật
    dir = target - dropletPos;
    dir = dir / norm(dir);  % Chuẩn hóa vector

    % Di chuyển giọt từng bước nhỏ để animation mượt
    for k = 1:numSteps
        % Cập nhật vị trí
        dropletPos = dropletPos + (stepSize/numSteps) * dir;

        % Vẽ lưới và điện cực
        cla;
        for i = 1:gridSize(1)
            for j = 1:gridSize(2)
                if electrodeMatrix(i,j) == 1
                    fill([j-1 j j j-1], [i-1 i-1 i i], 'cyan');
                else
                    rectangle('Position',[j-1, i-1, 1, 1], 'EdgeColor','k');
                end
            end
        end

        % Vẽ giọt nước
        theta = linspace(0, 2*pi, 100);
        x = dropletPos(2) + dropletRadius * cos(theta);
        y = dropletPos(1) + dropletRadius * sin(theta);
        fill(x-0.5, y-0.5, 'blue');
        title(sprintf('Step %d.%d', t, k));
        pause(0.05);  % Giảm nếu muốn nhanh hơn
    end
end
