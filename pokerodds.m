%Poker Odds Calculator written for Texas Hold 'em
%David Lu
%02/09/2015
%Returns odds of the home hand winning/splitting the pot
%Requires 3 inputs
%table - cards on the table
%home - cards held by the player
%visit - cards held by other players
%All cards are represented by an integer 1-52, 0 denotes an unknown card

function [win, split, lose] = pokerodds(table, home, visit)
    
    %Minimum number of iterations
    iter = 1000;
    %Acceptable error
    accept = 0.0001;


    %Count number of known cards
    known = nnz(table) + nnz(home) + nnz(visit);
    %disp(known);
    
    %Count number of zeros
    unknown = length(table) + length(home) + length(visit) - known;
    %disp(unknown);
    
    %Create deck
    deck = 1:52;
    
    %Remove known cards
    for i = 1:length(table)
        deck = deck(deck~=table(i));
    end
    for i = 1:length(home)
        deck = deck(deck~=home(i));
    end
    for i = 1:length(visit)
        deck = deck(deck~=visit(i));
    end
    
    %Display deck
    %disp(deck);
    
    %Initialize counters
    total = 0;
    wins = 0;
    loss = 0;
    tie = 0;
    
    %Calculate number of permutations
    permutations = 1;
    for i = length(deck) - unknown + 1:length(deck)
       %disp(i);
       permutations = permutations * i; 
    end
    
    %disp(permutations);
    
    %Permute deck RANDOMLY
    %Until acceptable percentage difference is found
    previous = 1;
    
    %Using ghetto do while
    while(true)
        %Randomly permute indices
        indices = randperm(length(deck), unknown);
        
        %disp(indices);
        
        %Slot indices into unknown places
        tableCopy = table;
        homeCopy = home;
        visitCopy = visit;
        
        i = 1;
        
        for j = 1:length(tableCopy)
           if(tableCopy(j) == 0)
               tableCopy(j) = deck(indices(i));
               i = i + 1;
           end
        end
        
        for j = 1:length(homeCopy)
           if(homeCopy(j) == 0)
               homeCopy(j) = deck(indices(i));
               i = i + 1;
           end
        end
        
        for j = 1:length(visitCopy)
           if(visitCopy(j) == 0)
               visitCopy(j) = deck(indices(i));
               i = i + 1;
           end
        end
        
        %Compare potential hands
        homeHand = besthand(tableCopy, homeCopy);
        
        %Find number of other players
        visiting = length(visitCopy) / 2;
        
        %Set checker
        checker = 0;
        
        %Check against every other hand
        for i = 1:visiting
            hand = besthand(tableCopy, [visitCopy(i), visitCopy(i+1)]);
            %disp(hand);
            comparing = comparehands(homeHand, hand);
            
            if(comparing < 0)
                checker = -9999;
            elseif(comparing == 0)
                checker = checker + 0;
                %disp(homeHand);
                %disp(hand);
            else
                checker = checker + 1;
            end
        end
        
        %Check win/loss/tie
        if(checker < 0)
            loss = loss + 1;
        elseif(checker == 0)
            tie = tie + 1;
        else
            wins = wins + 1;
        end
        total = total + 1;
        
        %disp([wins, loss, tie, total]);
        
        %Check for acceptable difference 
        if(abs(wins / total - previous) <= accept && total >= iter && (wins + loss + tie) > 0)
            break;
        else
            previous = wins / total;
        end
    end
    
    win = wins / total;
    split = tie / total;
    lose = loss / total;
    
    disp('Iterations:');
    disp(total);
    disp('Win:');
    disp(win);
    disp('Split:');
    disp(split);
    disp('Loss:');
    disp(lose);
end