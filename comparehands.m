%Poker Hand Comparator for Texas Hold 'em
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
    %Get hand ranks
    aRank = handrank(a);
    bRank = handrank(b);
  
    %Initialize winner
    winner = 0;

    %A has higher rank
    if(aRank > bRank)
       winner = 1;
    %B has higher rank
    elseif(aRank < bRank)
        winner = -1;
    %Equal rank
    else
        %Get values
        aValues = mod(a - 1, 13) + 1;
        
        %Fix aces to 14
        for i = 1:5
            if(aValues(i) == 1)
                aValues(i) = 14;
            end
        end
        
        bValues = mod(b - 1, 13) + 1;
        
        %Fix aces to 14
        for i = 1:5
            if(bValues(i) == 1)
                bValues(i) = 14;
            end
        end
        
        aValues = sort(aValues);
        bValues = sort(bValues);

        %Simple high card comparison, for high card, straight, flush, and
        %straight flush
        if((aRank == 1 || aRank == 5) || (aRank == 6 || aRank == 9))
            for i = 1:5
               if(aValues(6-i) > bValues(6-i))
                   winner = 1;
                   break;
               elseif(aValues(6-i) < bValues(6-i))
                   winner = -1;
                   break;
               end
            end
        %4oaK
        elseif(aRank == 8)
            %Get kickers
            if(aValues(1) == aValues(2))
                aKicker = aValues(5);
            else
                aKicker = aValues(1);
            end
            if(bValues(1) == bValues(2))
                bKicker = bValues(5);
            else
                bKicker = bValues(1);
            end
            %Compare middle cards
            if(aValues(3) > bValues(3))
                winner = 1;
            elseif(aValues(3) < bValues(3))
                winner = -1;
            %Equal main
            elseif(aKicker > bKicker)
                winner = 1;
            elseif(aKicker < bKicker)
                winner = -1;
            end
        %Full house
        elseif(aRank == 7)
            %Get triple and double
            aTrip = aValues(3);
            if(aValues(3) - aValues(1) == 0)
                aDoub = aValues(4);
            elseif(aValues(5) - aValues(3) == 0)
                aDoub = aValues(2);
            end
            bTrip = bValues(3);
            if(bValues(3) - bValues(1) == 0)
                bDoub = bValues(4);
            elseif(bValues(5) - bValues(3) == 0)
                bDoub = bValues(2);
            end

            %Compare
            if(aTrip > bTrip)
               winner = 1;
            elseif(aTrip < bTrip)
                winner = -1;
            else
                if(aDoub > bDoub)
                    winner = 1;
                elseif(aDoub < bDoub)
                    winner = -1;
                end
            end
        %3oaK
        elseif(aRank == 4)
             %Get kickers
            if(aValues(1) == aValues(3))
                aKicker1 = aValues(5);
                aKicker2 = aValues(4);
            elseif(aValues(2) == aValues(4))
                aKicker1 = aValues(5);
                aKicker2 = aValues(1);
            else
                aKicker1 = aValues(2);
                aKicker2 = aValues(1);
            end
            if(bValues(1) == bValues(3))
                bKicker1 = bValues(5);
                bKicker2 = bValues(4);
            elseif(bValues(2) == bValues(4))
                bKicker1 = bValues(5);
                bKicker2 = bValues(1);
            else
                bKicker1 = bValues(2);
                bKicker2 = bValues(1);
            end

            %Compare middle cards
            if(aValues(3) > bValues(3))
                winner = 1;
            elseif(aValues(3) < bValues(3))
                winner = -1;
            %Equal main
            else
                if(aKicker1 > bKicker1)
                    winner = 1;
                elseif(aKicker1 < bKicker1)
                    winner = -1;
                else
                    if(aKicker2 > bKicker2)
                        winner = 1;
                    elseif(aKicker2 < bKicker2)
                        winner = -1;
                    end
                end
            end
        %2P
        elseif(aRank == 3)
            %Get pairs
            aPair1 = aValues(4);
            aPair2 = aValues(2);
            bPair1 = bValues(4);
            bPair2 = bValues(2);

            %Get kickers
            if(aValues(1) == aValues(2) && aValues(3) == aValues(4))
                aKicker = aValues(5);

            elseif(aValues(2) == aValues(3) && aValues(4) == aValues(5))
                aKicker = aValues(1);
            else
                aKicker = aValues(3);
            end
            if(bValues(1) == bValues(2) && bValues(3) == bValues(4))
                bKicker = bValues(5);
            elseif(bValues(2) == bValues(3) && bValues(4) == bValues(5))
                bKicker = bValues(1);
            else
                bKicker = bValues(3);
            end

            %Compare
            if(aPair1 > bPair1)
                winner = 1;
            elseif(aPair1 < bPair1)
                winner = -1;
            else
                if(aPair2 > bPair2)
                    winner = 1;
                elseif(aPair2 < bPair2)
                    winner = -1;
                else
                    if(aKicker > bKicker)
                        winner = 1;
                    elseif(aKicker < bKicker)
                        winner = -1;
                    end
                end
            end
        %1P
        elseif(aRank == 2)
             %Get kickers and pairs
            if(aValues(1) == aValues(2))
                aPair = aValues(1);
                aKicker1 = aValues(5);
                aKicker2 = aValues(4);
                aKicker3 = aValues(3);
            elseif(aValues(2) == aValues(3))
                aPair = aValues(2);
                aKicker1 = aValues(5);
                aKicker2 = aValues(4);
                aKicker3 = aValues(1);
            elseif(aValues(3) == aValues(4))
                aPair = aValues(3);
                aKicker1 = aValues(5);
                aKicker2 = aValues(2);
                aKicker3 = aValues(1);
            else
                aPair = aValues(4);
                aKicker1 = aValues(3);
                aKicker2 = aValues(2);
                aKicker3 = aValues(1);
            end
            if(bValues(1) == bValues(2))
                bPair = bValues(1);
                bKicker1 = bValues(5);
                bKicker2 = bValues(4);
                bKicker3 = bValues(3);
            elseif(bValues(2) == bValues(3))
                bPair = bValues(2);
                bKicker1 = bValues(5);
                bKicker2 = bValues(4);
                bKicker3 = bValues(1);
            elseif(bValues(3) == bValues(4))
                bPair = bValues(3);
                bKicker1 = bValues(5);
                bKicker2 = bValues(2);
                bKicker3 = bValues(1);
            else
                bPair = bValues(4);
                bKicker1 = bValues(3);
                bKicker2 = bValues(2);
                bKicker3 = bValues(1);
            end

            %Compare
            if(aPair > bPair)
                winner = 1;
            elseif(aPair < bPair)
                winner = -1;
            else
                if(aKicker1 > bKicker1)
                    winner = 1;
                elseif(aKicker1 < bKicker1)
                    winner = -1;
                else
                    if(aKicker2 > bKicker2)
                        winner = 1;
                    elseif(aKicker2 < bKicker2)
                        winner = -1;
                    else
                        if(aKicker3 > bKicker3)
                            winner = 1;
                        elseif(aKicker3 < bKicker3)
                            winner = -1;
                        end
                    end
                end
            end
        end
    end
end