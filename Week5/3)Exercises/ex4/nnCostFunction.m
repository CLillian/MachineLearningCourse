function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% calculate the hypotheses of a training example
% note that this calculation does not depend on the label in question
X = [ones(m, 1) X];
hidden = sigmoid((Theta1 * X')');
hidden = [ones(m, 1) hidden];
output = sigmoid((Theta2 * hidden')');

% setup y to be a vector for each output
temp_y = zeros(m,num_labels);

% temp_y starts as zeroes, but ones go in each entry depending on the y value
for i = 1:m
  temp_y(i,y(i)) = 1;
end

left_term = (-temp_y) .* log(output);
right_term = (-temp_y + 1) .* log((-output) + 1);
  
%overall
J = (1 / m) * sum(sum(left_term - right_term));

regularization_term = 0;

for j = 1:size(Theta1,1)
  for k = 1:(size(Theta1,2)-1)
    regularization_term = regularization_term + Theta1(j,k+1)^2;
  end
end

for j = 1:size(Theta2,1)
  for k = 1:(size(Theta2,2)-1)
    regularization_term = regularization_term + Theta2(j,k+1)^2;
  end
end

regularization_term = regularization_term * (lambda / (2 * m));

J = J + regularization_term

% Calculate grad terms for backpropagation

for t = 1:m
  % STEP 1 of algorithm
  a_1 = X(t,:);
  
  z_2 = (Theta1 * a_1')';
  
  a_2 = sigmoid(z_2);
  a_2 = [1 a_2];
  
  z_3 = (Theta2 * a_2')';
  a_3 = sigmoid(z_3);
  
  % STEP 2 of algorithm
  delta_3 = a_3 - temp_y(t,:);
  
  % STEP 3 of algorithm
  delta_2 = (delta_3 * Theta2)(2:end) .* sigmoidGradient(z_2);
  
  % STEP 4 of algorithm
  Theta1_grad = Theta1_grad + (a_1' * delta_2)';
  Theta2_grad = Theta2_grad + (a_2' * delta_3)';
end

% STEP 5 of algorithm
Theta1_grad = Theta1_grad * (1 / m);
Theta2_grad = Theta2_grad * (1 / m);

% Regularisation
Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + ((lambda / m) * Theta1(:,2:end));
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + ((lambda / m) * Theta2(:,2:end));


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end