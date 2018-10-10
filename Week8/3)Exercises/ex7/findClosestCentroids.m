function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

% loop over each example in the training set
for i=1:size(X,1)
  % set the solution to the first one initially
  idx(i) = 1;
  min_dist = sum((X(i,:) - centroids(1,:)).^2);
  
  % loop over each centroid to find the min distance
  for j=1:size(centroids,1)
    % if the distance of the point X from the next centroid is less
    centroid_distance = sum((X(i,:) - centroids(j,:)).^2);
    
    if centroid_distance < min_dist
      % store the new distance and record it as the index
      idx(i) = j;
      min_dist = centroid_distance;
    end
  end
end

% =============================================================

end

