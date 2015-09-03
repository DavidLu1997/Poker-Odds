%Poker Odds Calculator written for Texas Hold 'em
%David Lu
%02/09/2015
%Returns odds of the home hand winning/splitting the pot
%Requires 3 inputs
%table - cards on the table
%home - cards held by the player
%visit - cards held by other players
%All cards are represented by an integer 1-52, 0 denotes an unknown card
function [win, split] = pokerodds(table, home, visit)
    
    %Count number of known cards
    known = nnz(table) + nnz(home) + nnz(visit);
    disp(known);
    
    %Count number of zeros
    unknown = length(table) + length(home) + length(visit) - known;
    disp(unknown);
    
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
    disp(deck);
    
    %Initialize counters
    total = 0;
    wins = 0;
    loss = 0;
    tie = 0;
    
    %Calculate number of permutations
    permutations = 1;
    for i = length(deck) - unknown + 1:length(deck)
       disp(i);
       permutations = permutations * i; 
    end
    
    disp(permutations);
    
    %Permute deck RANDOMLY
    %Until acceptable percentage difference is found
    %Define acceptable
    accept = 0.01;
    previous = 1;
    
    %Using ghetto do while
    while(true)
        %Randomly permute indices
        indices = randperm(length(deck), unknown);
        
        disp(indices);
        
        %Slot indices into unknown places
        tableCopy = table;
        homeCopy = home;
        visitCopy = visit;
        
        i = 1;
        
        for j = 1:length(tableCopy)
           if(tableCopy(i) == 0)
               tableCopy(i) = deck(indices(i));
               i = i + 1;
           end
        end
        
        for j = 1:length(homeCopy)
           if(homeCopy(i) == 0)
               homeCopy(i) = deck(indices(i));
               i = i + 1;
           end
        end
        
        for j = 1:length(visitCopy)
           if(visitCopy(i) == 0)
               visitCopy(i) = deck(indices(i));
               i = i + 1;
           end
        end
        
        %TODO Compare potential hands
        
        
        %Check for acceptable difference 
        if(abs(wins / total - previous) <= accept)
            disp(wins / total);
            disp('DONE');
            break;
        else
            previous = wins / total;
            disp(previous);
        end
    end
    
    win = wins / total;
    split = tie / total;
end