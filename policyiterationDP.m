Nx=101;
Nu=41;
x_grid= linspace(-5,5,101);
u_grid= linspace(-5,5,41);
policy= ones(Nx,1); %%bản chất chỉ là ánh xạ

policy_converged= false;
cnt=0;
max_iter=100;
V= zeros(Nx,1);
cnt=0;
gamma=0.95;

while ~policy_converged && cnt <max_iter
    
 converged=false;
    while ~converged
        V_new= zeros(Nx,1);
    for i= 1:Nx
    u=u_grid(policy(i));
    x_new = x_grid(i)+u;
    [~,idx] = min(abs(x_new-x_grid));
    cost = x_grid(i)^2+ u^2;
    V_new(i)= cost+gamma* V(idx);
    end 
    
    if norm(V_new-V)<1e-4
        converged=true;
    end
    V= V_new;
    end
   

    policy_new=zeros(Nx,1);
    for i= 1:Nx
      Q= zeros(Nu,1);
       for j=1:Nu
        u=u_grid(j);
        x_new=x_grid(i)+u;
        [~,idx] = min(abs(x_new-x_grid));
        cost = x_grid(i)^2+ u^2;
        Q(j)= cost+ gamma* V(idx);
       end
    [~,best_idx]= min(Q);
    policy_new(i)= best_idx;
    end

    if isequal(policy_new,policy)
        policy_converged=true;
    else
        policy=policy_new;
    end
   
   % ---- Cửa sổ 1: Value function ----
figure(1);
clf;
plot(x_grid, V, 'LineWidth',2);
title('Value function');
grid on;

% ---- Cửa sổ 2: Policy ----
figure(2);
clf;
plot(x_grid, u_grid(policy), 'LineWidth',2);
title('Optimal policy');
grid on;

drawnow;
    cnt=cnt+1;
end






