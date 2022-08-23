function [sigma, Q] = sol_TenBarTruss(r1, r2)
    %%
    % 定義各參數數值
    node_coordinate = [18.28 9.14; 18.28 0; 9.14 9.14; 9.14 0; 0 9.14; 0 0]; %節點座標
    nodei_near_element = [3; 1; 4; 2; 3; 1; 4; 3; 2; 1]; %元素旁的節點
    nodej_near_element = [5; 3; 6; 4; 4; 2; 5; 6; 3; 4]; %元素旁的節點
    E = 200000000000;

    A1 = pi*(r1)^2; A2 = pi*(r2)^2;
    A = [A1 A1 A1 A1 A1 A1 A2 A2 A2 A2]; %面積矩陣
    
    L = zeros(1,10);
    for n=1:10
        length = ((node_coordinate(nodej_near_element(n),1)-node_coordinate(nodei_near_element(n),1)).^2+...
            (node_coordinate(nodej_near_element(n),2)-node_coordinate(nodei_near_element(n),2)).^2).^0.5;
        L(n) = length;
    end %計算長度
    
    cos = zeros(1,10);
    for n=1:10
        C = (node_coordinate(nodej_near_element(n),1)-node_coordinate(nodei_near_element(n),1))/L(n);
        cos(n) = C;
    end
   
    sin = zeros(1,10);
    for n=1:10
        S = (node_coordinate(nodej_near_element(n),2)-node_coordinate(nodei_near_element(n),2))/L(n);
        sin(n) = S;
    end
    
    %element_table = [nodei_near_element,nodej_near_element,A.',L.',cos.',sin.'];

    %%
    % 開一個空白的剛性矩陣 (stiffness matrix)
    % K = ...
    K = zeros(12,12);

    % 計算 stiffness matrix (可使用 add_element 函數)
    % K = add_element ...
    for n=1:10
        K = add_element(K, A(n), E, L(n), cos(n), sin(n), nodei_near_element(n), nodej_near_element(n));
    end

    %%
    % 建立力矩陣(F=KQ)
    % F_matrix = ...
    F = [0 0 0 10000000 0 0 0 10000000 0 0 0 0];

    % 建立空白位移矩陣
    Q = zeros(1,12);
  
    % 計算位移量 (F = KQ)
    % 化簡各矩陣，因DOF9~DOF12無位移
    K_reduced = K; F_reduced = F; Q_reduced = Q;
    K_reduced([9,10,11,12],:) = []; %刪除剛性矩陣行
    K_reduced(:,[9,10,11,12]) = []; %刪除剛性矩陣列
    F_reduced(:,[9,10,11,12]) = [];
    Q_reduced(:,[9,10,11,12]) = [];

    Q_reduced = K_reduced\F_reduced; %**可能會有問題**

    % 建立空白應力矩陣
    sigma = [];
  
    % 計算應力 (stress) (可使用 compute_stress 函數)
    % sigma(1) = ...
    for n=1:10
        sigma = compute_stress(Q_reduced(n), E, L(n), cos(n), sin(n), nodei_near_element(n), nodej_near_element(n));
    end

    % (optional) compute reactions
    K_reaction = K; Q_reaction = Q;
    K_reaction([1 2 3 4 5 6 7 8],:) = [];
    K_reaction(:,[1 2 3 4 5 6 7 8]) = [];
    Q_reaction(:,[1 2 3 4 5 6 7 8]) = [];
    R = [];
    R = K_reaction*Q_reaction;

    Q = [Q_reduced Q_reaction];
  
end