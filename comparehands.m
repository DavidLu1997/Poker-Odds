%Poker hand comparator
%David Lu
%02/09/2015
%Compares two 5 card poker hands
%All cards represented as an integer from 1-52
%Standard Texas Hold 'em hands used
%Returns:
%1 if first hand wins
%-1 if first hand loses
%0 if pot is split
function winner = comparehands(a, b)
%Extract raw card values, returning integer between 1 and 13
avalues = mod(a - 1, 13) + 1;

print(avalues);

winner = 0;
end