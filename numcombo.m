%Finds number of combinations of possibilities
%David Lu
%08/01/2016
%Takes cards on the table, your cards, and opponent's cards, and number of
%cards remaining
%Cards run from 1-52, 0 denotes an unknown card
function combinations = numcombo(table, home, visit, cards) 
    combinations = 1;
    
    %Find number of known cards
    know1 = 0;
    know2 = 0;
    know3 = 0;
    
    for i = 1:length(table)
       if(table(i) ~= 0)
           know1 = know1 + 1;
       end
    end
    for i = 1:length(home)
       if(home(i) ~= 0)
           know2 = know2 + 1;
       end
    end
    
    %CANNOT KNOW OPPONENT'S CARDS
    %for i = 1:length(visit)
    %   if(home(i) == 0)
    %     know3 = know3 + 1;
    %  end
    %end
    
    %Number of unused cards
    cards = cards - know1 - know2 - know3;
    
    combinations = combinations * nchoosek(cards, length(table) - know1);
    combinations = combinations * nchoosek(cards - length(table) + know1, length(home) - know2);
    
    for i = 1:length(visit)/2
        combinations = combinations * nchoosek(cards - length(table) + know1 - length(home) + know2 - i * 2, 2);
    end
end