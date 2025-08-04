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
