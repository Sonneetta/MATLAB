function cobweb(x0, tol, a, b, n)
    format compact; 
    fs = 25; 
    lw = 2; 
    
    % Генеруємо значення X
    xx = linspace(a, b, n);
    
    % Визначаємо функцію
    cub = @(x) 4*x.*(1+x); 
    
    % Обчислюємо відповідні значення Y
    w = cub(xx);
    yy = xx;
    
    % Побудова вихідної функції
    figure(1);
    hold on;
    set(gca, 'DefaultLineLineWidth', lw);
    set(gca, 'FontSize', fs);
    xlabel('X(n)'); % Вісь X
    ylabel('X(n+1)'); % Вісь Y
    plot(xx, w, 'b', xx, yy, 'g', xx, xx*0, 'k', xx*0, xx, 'k');
    
    % Ініціалізуємо ітерацію
    i = 1;
    x(i) = x0;
    x(i+1) = cub(x(i));
    
    % Побудова початкової точки
    plot([x(i), x(i)], [0, x(i+1)], 'r');
    fprintf('x(%d)=%1.20f\n', i, x(i));
    
    % Ітераційний цикл
    while (((abs(x(i+1)-x(i)) > tol && abs(x(i+1)) < 3) || i < 5) && min(abs(x(end)-x(1:end-1))) > tol)
        i = i + 1;
        x(i+1) = cub(x(i));
        
        % Побудова ліній та точки для поточної ітерації
        plot([x(i-1), x(i)],[x(i), x(i)], 'r');
        plot([x(i), x(i)], [x(i), x(i+1)], 'r');
        fprintf('x(%d)=%1.20f\n', i, x(i));
        
        % Адаптація вісі
        axis auto;
        
        % Вихід з циклу (за потреби)
        break;
    end
    
    title('діаграма Ламерея', 'FontWeight', 'normal'); 
end
