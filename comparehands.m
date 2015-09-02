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

if(handrank(a) > handrank(b))
   winner = 1;
elseif(handrank(b) > handrank(a))
    winner = -1;
else
    
end
    
end