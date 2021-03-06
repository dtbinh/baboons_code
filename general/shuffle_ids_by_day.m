function [ data_shuffled ] = shuffle_ids_by_day( data, day_start_idxs )
%Shuffle the individual identities on each day. In other words, shuffle the
%columns of the NxT matrix 'data', independently for each day given in
%day_start_idxs.
%INPUTS:
%   data: [N x T x n_dim matrix] of values for each individual over time 
%       (e.g. xs or ys matrix). n_dim is the number of dimensions in the
%       data, for example you could enter an N x T x 2 matrix that contains
%       BOTH the x and y values for each individual, if you wanted to
%       shuffle the data such that the x and y values remained coupled
%   day_start_idxs: [1 x n_days vector] of the index to the start of each day
%OUTPUTS:
%   data_shuffled = [N x T matrix] of the same values, with the individual
%       identities shuffled on each day independently

%get size of data matrix
N = size(data,1);
T = size(data,2);
n_dim = size(data,3);

%number of days
n_days = length(day_start_idxs);

%add end point to day start idxs
day_start_idxs = [day_start_idxs T+1];

%shuffle data by day
data_shuffled = nan(N,T,n_dim);
for d = 1:n_days
    curr_dat = data(:,day_start_idxs(d):(day_start_idxs(d+1)-1),:);
    curr_dat = curr_dat(randperm(N),:,:);
    data_shuffled(:,day_start_idxs(d):(day_start_idxs(d+1)-1),:) = curr_dat;
end



end

