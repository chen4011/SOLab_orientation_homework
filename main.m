doc fmincon %利用 doc 查詢 fmincon 的使用方式
x0=[0.1;0.1]; %起始點
A=[-1 -3; 1 3; -1 -3; 1 1]; %線性不等式拘束條件的係數矩陣
b=[0 18 0 8]; %線性不等式拘束條件的係數向量 AX <= b
Aeq=[]; %線性不等式拘束條件的係數向量
beq=[]; %線性等式拘束條件的係數向量 AeqX = beq
ub=[6;6]; %設計空間的 upper bounds
lb=[0;0]; %設計空間的 lower bounds
options = optimset ('display','off','Algorithm','sqp');%演算法的參數設定
[x,fval,exitflag]=fmincon(@(x)obj(x),x0,A,b,Aeq,beq,lb,ub,...
@(x)nonlcon(x),options);
%執行fmincon，輸出最佳解,x; 最佳目標函數值,fval; 收斂情形,exitflag
%obj為目標函數，nonlcon 為 (非線性) 拘束條件