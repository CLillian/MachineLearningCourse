function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

% for each centroid we want to recalculate
for i=1:K
  number_of_points_in_centroid = 0;
  sum_of_Xs_for_centroid = zeros(1,n);
  
  % for each value in the index
  for j=1:size(idx)
    % if the value is in the centroid
    if idx(j) == i
      % record the number of points
      number_of_points_in_centroid = number_of_points_in_centroid + 1;
      % add the position of the datapoint to the summation
      sum_of_Xs_for_centroid = sum_of_Xs_for_centroid + X(j,:);
    end
  end
  
  % record the final centroid position by averaging the summed position
  centroids(i,:) = sum_of_Xs_for_centroid ./  number_of_points_in_centroid;
end







% =============================================================


end

