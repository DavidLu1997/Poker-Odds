%Print cards, translates 1-52 to standard card
%David Lu
%02/09/2015
%Takes a vector of integers
function printcards(cards)
    
    %Create value and suit vectors
    value = zeros(length(cards));
    suit = zeros(length(cards));
    
    %Get values
    value = mod(cards - 1, 13) + 1;
    
    %Get suits
    %1 - Spades
    %2 - Hearts
    %3 - Diamonds
    %4 - Clubs
    suit = ceil(cards / 13);
    
    for i = 1:length(cards)
        %Get Aces, Kings, Queens, Jacks and 10s
        if(value(i) == 1 || value(i) == 14)
            value(i) = 'A';
        elseif(value(i) == 13)
            value(i) = 'K';
        elseif(value(i) == 12)
            value(i) = 'Q';
        elseif(value(i) == 11)
            value(i) = 'J';
        elseif(value(i) == 10)
            value(i) = 'T';
        else
            value(i) = num2str(value(i));
        end
        
        %Get suits
        if(suit(i) == 1)
            suit(i) = 'S';
        elseif(suit(i) == 2)
            suit(i) = 'H';
        elseif(suit(i) == 3)
            suit(i) = 'D';
        else
            suit(i) = 'C';
        end
        
        fprintf('%s%s ', value(i), suit(i));
    end
    
    fprintf('\n');
end