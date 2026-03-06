Nx=101;
Nu=41;
x_grid= linspace(-5,5,101);
u_grid= linspace(-5,5,41);
policy= ones(Nx,1); %%bản chất chỉ là ánh xạ
max_iter=100;
V= zeros(Nx,1);
gamma=0.95;
V_new= zeros(Nu,1);
for iter= 1: max_iter
    V_old=V;
    for i=1:Nx
        for j=1:Nu
        u=u_grid(j);
        x_new= x_grid(i)+u;
        [~,idx]=min(abs(x_new-x_grid));
        cost= x_grid(i)^2+u^2;
        V_new(j)=cost+ gamma*V_old(idx);
        end
        [~,best_idx]= min(V_new);
        V(i)=V_new(best_idx);
    end
if norm(V-V_old,inf)<1e-4
    break;
end
 % ---- Cửa sổ 1: Value function ----
figure(1);
clf;
plot(x_grid, V, 'LineWidth',2);
title('Value function');
grid on;
end

for i=1:Nx
    Q=zeros(Nu,1);
        for j=1:Nu
            u=u_grid(j);
            x_new= x_grid(i)+u;
            [~,idx]=min(abs(x_new-x_grid));
            cost= x_grid(i)^2+u^2;
            Q(j)=cost+ gamma*V(idx);
        end
        [~,policy_idx]=min(Q);
        policy(i)=policy_idx;
end    
u_star = u_grid(policy);
figure(2);
clf;
plot(x_grid, u_star)
title('u=-kx')
grid on




  