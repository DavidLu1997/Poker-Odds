%Print card, translates 
%David Lu
%02/09/2015
function printcards(card)
    value = mod(card - 1, 13) + 1;
    
    if(value == 1)
        value = 14;
    end
    
    suit = ceil(card / 13);
    
    
end