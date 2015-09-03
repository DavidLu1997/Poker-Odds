%Best Poker Hand Creator
%David Lu
%02/09/2015
%Returns best hand out of 5 community cards and 2 hole cards
%Uses standard Texas Hold 'em poker hands
%All cards are represented by an integer 1-52

function best = besthand(table, hole)
    %Assume best hand is table hand
    best = table;
    
    %1 hole card used
    for i = 1:5
       for j = 1:2
           tableCopy = table;
           tableCopy(i) = hole(j);
           
           if(comparehands(tableCopy, best) > 0)
              best = tableCopy; 
           end
       end
    end
    
    %2 hole cards used
    for i = 1:5
        for j = 1:5
            if(i == j)
                continue;
            else
                tableCopy = table;
                tableCopy(i) = hole(1);
                tableCopy(j) = hole(2);
                
                if(comparehands(tableCopy, best) > 0)
                    best = tableCopy; 
                end
            end
        end
    end
end