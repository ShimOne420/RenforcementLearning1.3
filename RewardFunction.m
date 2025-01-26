    function [reward, done] = RewardFunction(mazeMap, drone, goal, moves)
        % Inizializza la ricompensa e il flag di terminazione
        reward = -1; % Piccola penalità per ogni passo
        done = false;   
    
        % Verifica se il drone colpisce un muro
        if mazeMap(drone(1), drone(2)) == 1
            reward = -50; % Grande penalità per il muro
            done = true; 
            disp(['Il drone ha colpito il muro con un reward di ', num2str(reward)]);
            return;
        end
    
        % Verifica se il drone ha raggiunto il goal
        if isequal(drone, goal)
            if moves <= 10
                reward = 300; % Ricompensa alta per arrivare in 10 mosse
            else
                reward = 150; % Ricompensa più bassa per più di 10 mosse
            end
            done = true;
            disp(['Il drone ha raggiunto il goal con un reward di ', num2str(reward)]);
            return;
        end
    
        % Penalità per troppi movimenti
        if moves > 10
            reward = reward - 5; % Penalità leggera per ogni mossa in più
        end
    end