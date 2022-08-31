function [g,geq]=nonlcon(x)
    %g(1) = -x(1,:)-3*x(2,:); %(非線性)拘束條件，g(1)<=0
    %g(2) = -18+x(1,:)+3*x(2,:); %g(2)<=0
    %g(3) = -x(1,:)-x(2,:); %g(3)<=0
    %g(4) = -8+x(1,:)+x(2,:); %g(4)<=0
    %geq=[]; %等式拘束條件，在本問題中沒有等式拘束條件，故為空集合
    [sigma,Q2] = sol_TenBarTruss(x(1,:),x(2,:));
    sigma_max = max(max(sigma));
    sigma_min = min(min(sigma));
    g(1) = sigma_max-250000000; % +σi ≤ σy
    g(2) = -sigma_min-250000000;% -σi ≤ σy
    g(3) = Q2-0.02; % ∆s2 ≤ 0.02
    geq=[]; %等式拘束條件，在本問題中沒有等式拘束條件，故為空集合