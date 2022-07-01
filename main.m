clc;
clear;
close all;
%% Problem Definition

problem.CostFunction = @(x) nQueen(x);  %Cost function

problem.nVar = 8;           % number of unknown (decision) variables

problem.VarMin =   1;       % Lower bound of decision variable
problem.VarMax =   8;       % upper bound of decision variable


%% Parameters of PSO

params.MaxIt = 50;          % Maximum number of iterations

params.nPop = 36;           % Popilation size (swarm size)

params.w = 1;               % Inertie coefficient
params.c1 = 2;              % Personal acceleration coefficient
params.c2 = 2;              % Social acceleration coefficient

%% Calling PSO

out = PSO(problem, params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;



%% Results

figure;
plot(BestCosts, 'LineWidth', 2);
%semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;


Mat = [128 0;0 128];
Mat = repmat(Mat, [problem.nVar/2 problem.nVar/2 3]);
[~,y] = sort(out.BestSol.Position);

for i=1:problem.nVar
    r=i;
    c=y(i);
    Mat(r,c,1)=255;
    Mat(r,c,2)=0;
    Mat(r,c,3)=0;
end
out.BestSol.Cost
imagesc(Mat)
