function new_state = apply_custom_rule(neighbors)
    % Custom Rule (Default: Rule 70)
    if neighbors(1) == 1 && neighbors(2) == 1 && neighbors(3) == 1
        new_state = 0;
    elseif neighbors(1) == 1 && neighbors(2) == 1 && neighbors(3) == 0
        new_state = 1;
    elseif neighbors(1) == 1 && neighbors(2) == 0 && neighbors(3) == 1
        new_state = 0;
    elseif neighbors(1) == 1 && neighbors(2) == 0 && neighbors(3) == 0
        new_state = 0;
    elseif neighbors(1) == 0 && neighbors(2) == 1 && neighbors(3) == 1
        new_state = 0;
    elseif neighbors(1) == 0 && neighbors(2) == 1 && neighbors(3) == 0
        new_state = 1;
    elseif neighbors(1) == 0 && neighbors(2) == 0 && neighbors(3) == 1
        new_state = 1;
    else
        new_state = 0;
    end
end

% GUI Initialization
clf
clear all

% Build the GUI
plotbutton = uicontrol('style','pushbutton',...
    'string','Run', ...
    'fontsize',12, ...
    'position',[100,400,50,20], ...
    'callback', 'run=1;');

erasebutton = uicontrol('style','pushbutton',...
    'string','Stop', ...
    'fontsize',12, ...
    'position',[200,400,50,20], ...
    'callback','freeze=1;');

quitbutton = uicontrol('style','pushbutton',...
    'string','Quit', ...
    'fontsize',12, ...
    'position',[300,400,50,20], ...
    'callback','stop=1;close;');
number = uicontrol('style','text', ...
    'string','1', ...
    'fontsize',12, ...
    'position',[20,400,50,20]);

% CA setup
n = 50; % Збільшення розмірів клітин
z = zeros(n,n);
cells = z;
sum = z;
cells(n/2, .25*n:.75*n) = 1;
cells(.25*n:.75*n, n/2) = 1;
cells = (rand(n,n)) < 0.5;

imh = image(cat(3, cells, cells, z)); % Сині клітини
set(imh, 'erasemode', 'none')
axis equal
axis tight

x = 2:n-1;
y = 2:n-1;

stop = 0;
run = 0;
freeze = 0;
stepnumber = 1;

while (stop == 0 && stepnumber <= 50)
    
    if (run == 1)
        updated_config = zeros(size(cells));
        for i = 1:n
            for j = 1:n
                neighbors = [cells(mod(i-2, n)+1, j), ...
                             cells(i, mod(j, n)+1), ...
                             cells(mod(i, n)+1, mod(j, n)+1)];
                updated_config(i, j) = apply_custom_rule(neighbors);
            end
        end
        cells = updated_config;

         set(imh, 'cdata', cat(3, cells, cells, z));

text(-10, 35.5, 'П', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 33, 'р', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 31, 'а', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 29, 'в', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 27, 'и', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 25, 'л', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 23, 'о', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);
text(-10, 20, '70', 'Rotation', 90, 'Color', 'k', 'FontSize', 17);


        stepnumber = 1 + str2num(get(number,'string'));
        set(number, 'string', num2str(stepnumber))
        pause(0.1);
    end
    
    if (freeze == 1)
        run = 0;
        freeze = 0;
    end
    drawnow
end
