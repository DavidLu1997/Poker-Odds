%Print cards, translates 1-52 to standard card
%David Lu
%02/09/2015
function printcards(cards)
    
    value = zeros(length(cards));
    suit = zeros(length(cards));

    for i = 1:length(cards)
        value(i) = mod(cards(i) - 1, 13) + 1;

        if(value(i) == 1)
            value(i) = 14;
        end

        suit(i) = ceil(cards(i) / 13);
    end
    
    disp(value);
    disp(suit);
end