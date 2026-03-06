A = [0 1;
     -0.2 -0.9];

B = [0;
     0.1];

Q = [10 0;
     0 1];

R = 1;
K = [0 0];
P_err=[];
K_err=[];
saisoP=[];
saisoK=[];
for j=1:50
    
    D= A-B*K;
    P= dlyap(D',Q+K'*R*K);
    if j>1
        P_err(j)= norm(P-P_old);
    end

    K_new= (R+B'*P*B) \ B'*(P*A);
    K_err(j)= norm(K_new-K);
    if norm(K_new-K)<1e-4
        break;
    end
    P_old=P;
    K=K_new;
    
    [P_opt,~,K_opt] = dare(A,B,Q,R);
    saisoP(j)=norm(P-P_opt);
    saisoK(j)=norm(K-K_opt);
    figure(1);
    clf;
    plot(P_err);
    title('tốc độ hội tụ P');
    drawnow;

    figure(2);
    clf;
    plot(K_err);
    title('tốc độ hội tụ K');
    drawnow;



    figure(3);
    clf;
    plot(saisoP);
    title('sai so P voi nghiem riccati');
    drawnow;

    figure(4);
    clf;
    plot(saisoK);
    title('Sai so K voi nghiem riccati');
    drawnow;




end    
