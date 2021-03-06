function [ output_args ] = show_high_prob_states( state_probs, topN, baboon_info )
%Makes a plot of the high probability states, based on a vector of state
%probabilities (ordered according to a binary transformation).
%INPUTS:
%   state_probs: [1 x 2^N vector] of probabilities for each state
%   topN: the number of states to show (highest or lowest probability states)
%   baboon_info: struct of baboon information
%OUTPUTS:
%   a plot of the highest probability states

N = length(baboon_info);

if length(state_probs) ~= 2^N
    error('wrong number of baboons in baboon_info struct or wrong number of states in probabilities vector')
end

[probs idxs] = sort(state_probs,'ascend');
idxs = idxs(1:topN);

data = zeros(N,topN);
for i = 1:length(idxs)
    idx = idxs(i);
    xi = dec2bin(idx-1,N) - '0'; %convert to binary
    data(:,i) = xi;
end

figure
hold on;
imagesc(data,[0 1])
colors = [1 0 0; 0 1 1]; 
colormap(colors)
axis([-topN/10 topN+1 0 N+1])

%for i = 0:N+1
%    plot([.5 topN+.5],[i-.5 i-.5],'--k')
%end

%for i = 0:topN
%    plot([i+.5 i+.5],[0.5 N+.5],'-k','LineWidth',2)
%end

for i = 1:N
    y = i
    
    %get appropriate color for age/sex class
    if strcmp(baboon_info(i).sex,'M')
    	if strcmp(baboon_info(i).age,'A')
        	col = [0 0 255]./255;
        elseif strcmp(baboon_info(i).age,'SA')
        	col = [102 204 255]./255;
        else
        	col = [102 102 102]./255;
        end
    else
    	if strcmp(baboon_info(i).age,'A')
    		col = [255 0 0]./255;
    	elseif strcmp(baboon_info(i).age,'SA')
    		col = [255 204 102]./255;
    	else
    		col = [102 102 102]./255;
    	end
   end
    
    %get appropriate marker shape for sex
    if strcmp(baboon_info(i).sex,'M')
        mark = 'o';
    elseif strcmp(baboon_info(i).sex,'F')
        mark = 'o';
    end
    
    plot(-topN/40,y,mark,'MarkerSize',10,'MarkerFaceColor',col,'MarkerEdgeColor',col)
    h1=text(-topN/20,y,baboon_info(i).collar_num,'Color','black','FontWeight','bold','HorizontalAlignment','Center');
end

title(sprintf('The top %d most likely states',topN),'FontWeight','bold','FontSize',20)

end

