% Mô phỏng giọt nước 3D chuyển động và hiệu ứng GIF
filename = 'giot_3D_tonghop.gif';
fig = figure('Position',[100 100 700 500]);
axis([-5 5 -5 5 -5 5]); axis manual; hold on;
view(3); camlight; lighting gouraud;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Mô phỏng giọt nước 3D');

% Tạo hình cầu đơn vị
[X,Y,Z] = sphere(40); r = 0.5;

%% --- 1. Chuyển động thẳng + đổi màu ---
for t = 0:0.1:3
    x = -2 + t*1.5;
    y = 0;
    z = 0;
    c = [sin(t)^2 cos(t)^2 sin(t/2)^2];  % màu động
    surf(x+X*r, y+Y*r, z+Z*r, 'FaceColor', c, 'EdgeColor','none');
    drawnow;

    frame = getframe(fig);
    img = frame2im(frame);
    [imind, cm] = rgb2ind(img,256);
    if t == 0
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.02);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.02);
    end

    cla;  % xóa nội dung sau mỗi bước để không chồng hình
end

%% --- 2. Lượn sóng + hiệu ứng nhập giọt ---
for t = 0:0.1:5
    x1 = -1 + t*0.3;
    z1 = sin(t);
    x2 =  1 - t*0.3;
    z2 = -sin(t);
    dist = abs(x1 - x2);

    if dist < 0.5
        % nhập giọt: tạo một giọt lớn
        surf((x1+x2)/2 + X*r*1.3, Y*r*1.3, (z1+z2)/2 + Z*r*1.3, 'FaceColor',[0.5 0 1],'EdgeColor','none');
    else
        surf(x1+X*r, Y*r, z1+Z*r, 'FaceColor','b','EdgeColor','none');
        surf(x2+X*r, Y*r, z2+Z*r, 'FaceColor','g','EdgeColor','none');
    end

    drawnow;
    frame = getframe(fig);
    img = frame2im(frame);
    [imind, cm] = rgb2ind(img,256);
    imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.02);

    cla;
end

%% --- 3. Nhảy điện cực + tách giọt ---
electrodeX = [-2 0 2];
for i = 1:length(electrodeX)
    x0 = electrodeX(i);
    surf(x0+X*r, Y*r, Z*r, 'FaceColor','m','EdgeColor','none');

    frame = getframe(fig);
    img = frame2im(frame);
    [imind, cm] = rgb2ind(img,256);
    imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);

    cla;

    % Tách giọt tại điện cực
    for t = 1:15
        dx = 0.3 - t*0.01;
        surf((x0 - dx) + X*r*0.7, Y*r*0.7, Z*r*0.7, 'FaceColor','c','EdgeColor','none');
        surf((x0 + dx) + X*r*0.7, Y*r*0.7, Z*r*0.7, 'FaceColor','y','EdgeColor','none');
        drawnow;

        frame = getframe(fig);
        img = frame2im(frame);
        [imind, cm] = rgb2ind(img,256);
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.02);

        cla;
    end
end
