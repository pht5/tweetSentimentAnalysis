function Y = doTSNE(X)
%% Simple t-SNE example
% Patrick Terry (pht5)
% Equation numbers reference van der Maaten and Hinton t-SNE paper

%N is number of points, C is higher dimension
[N, C] = size(X);

%% t-SNE parameters and distributions
%Lower dimension for visualization
D = 2;
%Number of iterations
T = 15;
%Learning Rate each iteration
learningRate = 5;
%Defining Sigma (technically you're supposed to do something much fancier
%here, but I think picking an arbitrary value that works is fine for this
%illustration
sigma = zeros(N, 1) + 1;

gauss = @(x, y, sig) exp(-norm(x-y)^2/(2*sig^2));
studentT = @(x,y) (1 + norm(x-y)^2)^(-1);

%% Running t-SNE
% Define P
pJGivenI = zeros(N);
for i = 1:N
    %Calculate the denominator first, since it doesn't depend on j
    denom = 0;
    for k = 1:N
        if k ~= i
            denom = denom + gauss(X(i, :), X(k,:), sigma(i));
        end
    end
    for j = 1:N
        if i == j
            pJGivenI(i,j) = 0;
        else
            pJGivenI(i,j) = gauss(X(i, :), X(j,:), sigma(i))/denom; %(Eq. 1)
        end
    end
end
P = zeros(N);
for i = 1:N
    for j = 1:N
        P(i,j) = (pJGivenI(i,j) + pJGivenI(j,i))/(2*N);
    end
end

%Define initial Y
Y = normrnd(0,10^0,N,2);
for t = 1:T
    %Compute Q
    Q = zeros(N);
    denom = 0;
    %Calculate the denominator first, doesn't depend on i or j
    for k = 1:N
        for l = 1:N
            if k ~= l
                denom = denom + studentT(Y(k,:),Y(l,:));
            end
        end
    end
    for i = 1:N
        for j = 1:N
            if i ~= j
                Q(i,j) = studentT(Y(i,:),Y(j,:))/denom; %(Eq. 4)
            end
        end
    end
    %Compute gradient
    grad = zeros(N,2);
    for i = 1:N
        tot = [0,0];
        for j = 1:N
            tot = tot + (P(i,j)-Q(i,j)).*(Y(i,:)-Y(j,:)).*studentT(Y(i,:),Y(j,:)); %(Eq. 5)
        end
        grad(i,:) = tot.*4;
    end

    %Set new Y
    Y = Y - learningRate * grad;
end
end



