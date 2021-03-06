%% part a: Formulate a linear program

% Objective coefficient (Take inverse to get maximum)
c1 = [20, (20 - 15) * 100, 100]';
c2 = [40, (40 - 15) * 100, 100]';
c3 = [12, 0, 100]';
c = -1 * (c1 + c2 + c3) / 3;

% Inequality constraints
A = [];
b = [];

% Equality constraints
Aeq = [20, 1000, 90];
beq = [20000];

% Variable bounds
ub = [inf, 50, inf]';
lb = [0, -50, 0]';

% Call linprog from matlab
fprintf('Part A\n')
[x, fval] = linprog(c, A, b, Aeq, beq, lb, ub);
fprintf('Investing in:\n\t%.2f shares of stocks\n\t%.2f options\n\t%.2f bonds\n', x(1), x(2), x(3))
fprintf('Total estimated profit:\t$%d\n\n', round(-1 * fval - 20000))

%% part b: Does the portfolio make profit in evert case?

% Calculate the profit in each case
profit_1 = c1' * x - 20000;
profit_2 = c2' * x - 20000;
profit_3 = c3' * x - 20000;
fprintf('Part B\n')
fprintf('Profit in case 1: %.2f\n', profit_1);
fprintf('Profit in case 2: %.2f\n', profit_2);
fprintf('Profit in case 3: %.2f\n\n', profit_3);

%% part c: Have at least 2000 profit in all scenarios
% Inequility constraints (Take inverse to get "greater than")
A = -1 * [c1'; c2'; c3'];
b = -1 * 22000 * ones(3, 1);

% Call linprog from matlab
fprintf('Part C\n')
[x, fval] = linprog(c, A, b, Aeq, beq, lb, ub);
fprintf('Investing in:\n\t%.2f shares of stocks\n\t%.2f options\n\t%.2f bonds\n', x(1), x(2), x(3))
profit_1 = c1' * x - 20000;
profit_2 = c2' * x - 20000;
profit_3 = c3' * x - 20000;
fprintf('Profit in case 1: %.2f\n', profit_1);
fprintf('Profit in case 2: %.2f\n', profit_2);
fprintf('Profit in case 3: %.2f\n\n', profit_3);

%% part d: Max riskless profit under all three scenarios

% Introduce new riskless profit p, which is the objective function. Take
% inverse to maximize
c = -1 * [0, 0, 0, 1]';

% Inequality constraints. Take inverse to get lower limit
A = -1 * [c1', -1; c2', -1; c3', -1];
b = [0, 0, 0]';

% Equality constraints
Aeq = [Aeq, 0];
beq = [20000];

% Variable bounds
ub = [ub; inf];
lb = [lb; -inf];

fprintf('Part D\n')
[x, fval] = linprog(c, A, b, Aeq, beq, lb, ub);
fprintf('Investing in:\n\t%.2f shares of stocks\n\t%.2f options\n\t%.2f bonds\n', x(1), x(2), x(3))
fprintf('Maximum riskless profit:\t%.2f\n', round(x(4),2) - 20000)