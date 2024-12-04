clc;
clear;
close all;

% Environment Parameters
xrange = 9; % Width of the environment
yrange = 7; % Height of the environment

% Maze Map (1 for walls, 0 for free spaces)
mazeMap = [
    1, 1, 1, 1, 1, 1, 1, 1, 1;
    1, 0, 0, 0, 1, 0, 0, 0, 1;
    1, 1, 0, 0, 0, 0, 0, 1, 1;
    0, 0, 0, 1, 0, 1, 0, 0, 0;
    1, 0, 0, 1, 1, 1, 0, 0, 1;
    1, 0, 0, 0, 1, 0, 0, 0, 1;
    1, 1, 1, 1, 1, 1, 1, 1, 1
];

% Q-learning Parameters
alpha = 0.2; % Learning rate (weight)
gamma = 0.90; % Discount factor (future rewards)
epsilon = 0.3; % Exploration rate (probability of choosing new actions)
num_actions = 4; % Actions (up, down, left, right)

if exist('q_table1.mat', 'file') == 2
    load('q_table1.mat', 'q_table');  % Load the saved Q-table
    disp('Q-table loaded successfully.');
else
    q_table = zeros(xrange, yrange, num_actions);  % Initialize a new Q-table
    disp('No Q-table found. Starting with a new Q-table.');
end

% Training Loop Parameters
num_episodes = 385; % Total episodes for training

% Array to store cumulative rewards for each episode
cumulative_rewards = zeros(num_episodes, 1); 

% Q-learning Training Loop
for episode = 1:num_episodes
    % Initialize the environment with drone and goal positions
    [drone, goal] = ResetFunction(xrange, yrange);
    
    % Termination flag
    done = false;

    % Visualization Setup
    figure;
    hold on;
    
    % Draw the maze
    for i = 1:size(mazeMap, 1)
        for j = 1:size(mazeMap, 2)
            if mazeMap(i, j) == 1
                rectangle('Position', [j - 0.5, i - 0.5, 1, 1], 'FaceColor', 'k');
            end
        end
    end

    % Draw the goal
    plot(goal(2), goal(1), 'go', 'MarkerSize', 10, 'DisplayName', 'Goal');

    % Initialize drone visualization
    drone_plot = plot(drone(2), drone(1), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

    axis([0 xrange 0 yrange]);
    legend;
    title(['Episode: ', num2str(episode)]);
    xlabel('X Position');
    ylabel('Y Position');
    pause(0.1);

    % Initialize total reward for this episode and moves counter
    episode_reward = 0; 
    moves = 0;

    while ~done
        % Convert drone's position to discrete state indices for the Q-table
        state_x = drone(1);
        state_y = drone(2);
        
        % Make sure the state indices are within the grid bounds (1 to xrange and 1 to yrange)
state_x = max(1, min(xrange, state_x));  % Clamping state_x to the valid range
state_y = max(1, min(yrange, state_y));  % Clamping state_y to the valid range

        % Choose an action using epsilon-greedy strategy
        if rand < epsilon
            action = randi(num_actions); % Explore
        else
            [~, action] = max(q_table(state_x, state_y, :)); % Exploit
        end

        % Execute the chosen action and calculate the next position
        switch action
            case 1 % Move up
                next_drone = [max(drone(1) - 1, 1), drone(2)];
            case 2 % Move down
                next_drone = [min(drone(1) + 1, yrange), drone(2)];
            case 3 % Move left
                next_drone = [drone(1), max(drone(2) - 1, 1)];
            case 4 % Move right
                next_drone = [drone(1), min(drone(2) + 1, xrange)];
        end

        % Check if the drone hits a wall or reaches the goal and compute reward
        [reward, done] = RewardFunction(mazeMap, next_drone, goal, moves);
        drone = next_drone; % Update the drone's position
        episode_reward = episode_reward + reward; % Accumulate reward
        moves = moves + 1; % Increment moves

       % Update Q-table using Q-learning formula
       next_state_x = max(1, min(xrange, round(drone(1))));  % Ensure next_state_x is within bounds
       next_state_y = max(1, min(yrange, round(drone(2))));  % Ensure next_state_y is within bounds

       best_next_action = max(q_table(next_state_x, next_state_y, :));  % Get the best next action from Q-table

% Q-learning update formula
q_table(state_x, state_y, action) = (1 - alpha) * q_table(state_x, state_y, action) + ...
    alpha * (reward + gamma * best_next_action);  % Update the Q-table
        % Update drone visualization
        set(drone_plot, 'XData', drone(2), 'YData', drone(1));
        pause(0.1);
    end

    % Save the cumulative reward for the episode
    cumulative_rewards(episode) = episode_reward;

    disp(['Episode ', num2str(episode), ' completed with reward: ', num2str(episode_reward)]);
end

disp('Training completed.');

% After the training loop, calculate the average reward
if num_episodes > 1
    average_reward = cumsum(cumulative_rewards) ./ (1:num_episodes)'; % Cumulative average
else
   average_reward = cumulative_rewards; % If only one episode, use that reward
end




% Plot the average reward
figure;
plot(average_reward);
xlabel('Episode');
ylabel('Average Reward');
title('Average Reward over Episodes');
grid on;

% Save the Q-table
save('q_table1.mat', 'q_table');

