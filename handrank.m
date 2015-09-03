%Ranks a 5 card poker hand
%All cards represented as an integer from 1-52
%Standard Texas Hold 'em hands used
%Returns:
%High Card - 1
%Pair - 2
%Two pair - 3
%Three of a Kind - 4
%Straight - 5
%Flush - 6
%Full House - 7
%Four of a Kind - 8
%Straight Flush - 9
function rank = handrank(a)

    %Extract raw card values, returning integer between 1 and 13
    values = mod(a - 1, 13) + 1;
    
    %Fix aces to 14
    for i = 1:5
        if(values(i) == 1)
            values(i) = 14;
        end
    end
    
    %Sort
    values = sort(values);

    %Extract raw suits, returning integer between 1 and 4
    suits = ceil(a / 13);

    %disp('Hand:');
    %disp(values);
    %disp(suits);

    %Check for straight
    straight = sort(values);
    for i = 2:5
        if(straight(i) - straight(1) ~= i - 1)
           straight = false; 
           break;
        end
    end
    if(straight ~= false)
       straight = true; 
    end

    %Check for flush
    flush = sort(suits);
    if(flush(5) - flush(1) == 0)
        flush = true;
    else
        flush = false;
    end

    %Straight Flush
    if(flush + straight == 2)
        rank = 9;
    %Flush only
    elseif(flush == true && straight == false)
       rank = 6;
    %Straight only
    elseif(flush == false && straight == true)
       rank = 5;
    %Check for other hands, destroying suit information
    else
        values = sort(values);
    
        %4oaK, difference between largest and 4th largest is 0 or difference
        %between 2nd and 5th is 0
        if(values(5) - values(2) == 0 || values(4) - values(1) == 0)
            rank = 8;
        %FH, difference between largest and 3rd is 0, and smallest and 4th is
        %0, or other way around
        elseif((values(5) - values(3) == 0 && values(2) - values(1) == 0) || (values(5) - values(4) == 0 && values(3) - values(1) == 0))
            rank = 7;
        %3oaK, difference between any 3 is 0
        elseif(values(5) - values(3) == 0 || (values(4) - values(2) == 0 || values(3) - values(1) == 0))
            rank = 4;
        %2P, finding 2 pairs
        elseif((values(5) - values(4) == 0 && values(3) - values(2) == 0) || ((values(4) - values(3) == 0 && values(2) - values(1) == 0) || (values(5) - values(4) == 0 && values(2) - values(1) == 0)))
            rank = 3;
        %1P, finding 1 pair
        elseif((values(5) - values(4) == 0 || values(4) - values(3) == 0) || (values(3) - values(2) == 0 || values(2) - values(1) == 0))
            rank = 2;
        %High Card
        else
            rank = 1;
        end
    end
end
