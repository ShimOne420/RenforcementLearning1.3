# RenforcementLearning1.3
# Path Planning with Q-Learning in a Grid-World
## Project Description
This project implements a path planning algorithm using Q-learning, a reinforcement learning technique, in a grid-world environment. The goal is to train an agent (a drone) to navigate through a maze, avoid obstacles, and reach a predefined goal position while optimizing its path.

The project focuses on high-level control, where the agent learns decision-making strategies (discrete actions such as up, down, left, and right) to achieve the goal efficiently. The environment is static, and state transitions are deterministic.

This project is a collaborative work by **Simone Mercolino** and **Francesco Pastore** as part of a course assignment.
## Features
- Implements Q-learning for path planning.
- Agent learns to navigate in a grid-world environment.
- Reward system to encourage efficient navigation:
  - Positive rewards for reaching the goal.
  - Penalties for collisions or unnecessary steps.
- Visual representation of the agent's learning process and behavior.
- Modular structure for easy modifications and extensions.
## How It Works
1. **Environment**:
   - A grid-world maze is defined where:
     - `1` represents walls (obstacles).
     - `0` represents free spaces.
   - The agent starts at a predefined position and aims to reach the goal.

2. **State Representation**:
   - The state is defined as the agent's current position \((x, y)\) in the grid.

3. **Actions**:
   - The agent can move in four directions:
     - `1`: Up
     - `2`: Down
     - `3`: Left
     - `4`: Right

4. **Reward System**:
   - **+100**: Reaching the goal efficiently.
   - **-100**: Colliding with a wall.
   - **-1**: Small penalty for each step to encourage shorter paths.
   - Additional penalties for excessive steps.

5. **Q-learning Algorithm**:
   - The agent uses a Q-table to store the expected cumulative reward for each state-action pair.
   - The Q-values are updated using the formula:
     \[
     Q(x, y, a) \leftarrow (1 - \alpha) Q(x, y, a) + \alpha \left[ r + \gamma \max_{a'} Q(x', y', a') \right]
     \]
   - Parameters:
     - Learning rate (\(\alpha\)): 0.2
     - Discount factor (\(\gamma\)): 0.9
     - Exploration rate (\(\epsilon\)): 0.3 (epsilon-greedy policy).
## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/username/path-planning-q-learning.git

---

#### **6. Usage**
Explain how to use the project and interpret the results.

```markdown
## Usage
1. **Training**:
   - Run the `Main.m` script to train the agent.
   - During training, the maze and agent's movement are visualized.
   - The Q-table is saved after training (`q_table1.mat`).

2. **Visualization**:
   - The agent's learning process is visualized step by step.
   - Observe how the agent improves its path over episodes.

3. **Testing**:
   - Use the saved Q-table to test the agent's performance without retraining.
   - Modify the goal or starting position to test the agent's adaptability.
## Results
- The agent successfully learns to navigate the grid-world environment and reaches the goal efficiently after sufficient training.
- Observations:
  - Initially, the agent explores randomly, leading to suboptimal paths and collisions.
  - Over time, the agent learns to avoid walls and take the shortest path to the goal.
  - The Q-table reflects the optimal policy, with high Q-values corresponding to the best actions.
## Parameters
- `alpha` (Learning Rate): Controls how much the agent learns from new information.
- `gamma` (Discount Factor): Balances the importance of immediate and future rewards.
- `epsilon` (Exploration Rate): Governs the trade-off between exploration and exploitation.
- `num_episodes`: Number of episodes for training.
- Grid dimensions (`xrange`, `yrange`): Size of the grid-world environment.
- Reward system: Modify rewards and penalties to change the agent's behavior.
## File Structure
- `Main.m`: Main script for training and visualizing the agent.
- `ResetFunction.m`: Initializes the environment (drone and goal positions).
- `RewardFunction.m`: Defines the reward system based on the agent's actions.
- `q_table1.mat`: Saved Q-table after training.
## Authors
- **Simone Mercolino**
- **Francesco Pastore**


