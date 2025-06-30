
load("results/estAp4_layer2.mat")
load("results/W_fullp4_layer2.mat")
load("results/Lambda_fullp4_layer2.mat")
writematrix(estA,"csv/estAp4_layer2.csv")
W(W>10^-4) = 1;
W(W<10^-4) = 0;
sum(W)
writematrix(Lambda(:,1), "csv/estB_p4_layer2.csv");
writematrix(W, "csv/W_p4_layer2.csv")

load("results/estAp3_layer2.mat")
load("results/W_fullp3_layer2.mat")
load("results/Lambda_fullp3_layer2.mat")
writematrix(estA,"csv/estAp3_layer2.csv")
W(W>10^-4) = 1;
W(W<10^-4) = 0;
sum(W)
writematrix(Lambda(:,1), "csv/estB_p3_layer2.csv");
writematrix(W, "csv/W_p3_layer2.csv")

load("results/estAp2_layer2.mat")
load("results/W_fullp2_layer2.mat")
load("results/Lambda_fullp2_layer2.mat")
writematrix(estA,"csv/estAp2_layer2.csv")
W(W>10^-4) = 1;
W(W<10^-4) = 0;
sum(W)
writematrix(Lambda(:,1), "csv/estB_p2_layer2.csv");
writematrix(W, "csv/W_p2_layer2.csv")


load("results/estAp1_layer2.mat")
load("results/W_fullp1_layer2.mat")
load("results/Lambda_fullp1_layer2.mat")
writematrix(estA,"csv/estAp1_layer2.csv")
W(W>10^-4) = 1;
W(W<10^-4) = 0;
sum(W)
writematrix(Lambda(:,1), "csv/estB_p1_layer2.csv");
writematrix(W, "csv/W_p1_layer2.csv")
