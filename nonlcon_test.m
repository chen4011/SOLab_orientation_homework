function [g,geq]=nonlcon_test(x)
g(1) = -x(1,:)-3*x(2,:); %(非線性)拘束條件，g(1)<=0
g(2) = -18+x(1,:)+3*x(2,:); %g(2)<=0
g(3) = -x(1,:)-x(2,:); %g(3)<=0
g(4) = -8+x(1,:)+x(2,:); %g(4)<=0
geq=[];%等式拘束條件，在本問題中沒有等式拘束條件，故為空集合