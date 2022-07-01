function out = PSO(problem, params)
    %% Problem Definition
    
    CostFunction = problem.CostFunction;  
    nVar = problem.nVar;            

    VarSize = [1 nVar];             

    VarMin = problem.VarMin;        
    VarMax = problem.VarMax;       


    %% Parameters of PSO

    MaxIt = params.MaxIt;      

    nPop = params.nPop;         

    w = params.w;                    
    c1 = params.c1;             % Personal acceleration coefficient
    c2 = params.c2;             % Social acceleration coefficient    
    
    %% Initialization

    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];

    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);

    % Initialise Global Best
    GlobalBest.Cost = inf;

    % Initialise Population Members
    for i=1:nPop
    
        % Generate Random Solution
        particle(i).Position = unifrnd(VarMin, VarMax, VarSize);
    
        %Initialize velocity
        particle(i).Velocity = zeros(VarSize);
    
        % Evaluation
        particle(i).Cost = CostFunction(particle(i).Position);
    
        % Update the Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;
    
        % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
        end    
    
    end  

    BestCosts = zeros(MaxIt, 1);


    %% Main Loop of PSO

    for it=1:MaxIt
        for i=1:nPop
        
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity...
                + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position)...
                + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);
            
            % Update Position
            particle(i).Position = particle(i).Position+ particle(i).Velocity;
            
            % Apply Lower and Upper Bound Limits
            particle(i).Position = max(particle(i).Position , VarMin);
            particle(i).Position = min(particle(i).Position , VarMax);
            
            % Evaluation
            particle(i).Cost = CostFunction(particle(i).Position);
        
            % Update Personal Best
            if particle(i).Cost < particle(i).Best.Cost
        
                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;
                % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                end
            
            end
        
        end
    
        % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;
    
        % Display Iteration Information
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
        
    
    end
    
    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    
    
end