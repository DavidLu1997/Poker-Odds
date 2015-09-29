%Code cards, translates standard card to 1-52
%David Lu
%27/09/2015
%Takes a vector of strings
function cards = codecards(a)
    cards = zeros(size(a, 1));
    
    for i = 1:size(a, 1);
        if(a(i) == 0)
            continue;
        end
        switch(a(i, 1))
            case 'T'
                cards(i) = cards(i) + 10;
            case 'J'
                cards(i) = cards(i) + 11;
            case 'Q'
                cards(i) = cards(i) + 12;
            case 'K'
                cards(i) = cards(i) + 13;
            case 'A'
                cards(i) = cards(i) + 1;
            otherwise
                cards(i) = str2num(a(i, 1));
        end
        switch(a(i, 2))
            case 'S'
                cards(i) = cards(i);
            case 'H'
                cards(i) = cards(i) + 13;
            case 'D'
                cards(i) = cards(i) + 26;
            case 'C'
                cards(i) = cards(i) + 39;
        end
    end
    
end