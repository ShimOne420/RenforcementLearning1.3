% Funzione per inizializzare l'ambiente
function [drone, goal] = ResetFunction(xrange, yrange)
    % Posizione iniziale del drone
    drone = [4, 1];
    
    % Imposta il goal
    goal = [4, 9];
end