%decoding - using for testing

image = imread('testing.png');
[height, width, testing] = size(image); %getting the 

R = image(:, :, 1);
G = image(:, :, 2);
B = image(:, :, 3);
messagestring = '';
delimitorCounter = 0; %the z's when going through the messagestring
bitCounter = 0; %once it reaches 4 then that's 1 character
eightbitPX = ''; 

for rowChannel = 1:height
    for columnChannel = 1:width 
        if (delimitorCounter == 10)
            break;
        end
        binaryPX = dec2bin( R(rowChannel, columnChannel),8 ); %get uint8 number and translate to bits
        eightbitPX = strcat(eightbitPX, binaryPX(7:8));  %add last 2 bits to 8 bit string
        bitCounter = bitCounter + 1; %once this reaches 4 (8/2) we reached 8 bits
        %once 8 bits are reached (aka 1 character) in the message we want
        %to convert to character --> store in message array
        if (bitCounter == 4)
            pxCharacter = char(bin2dec(eightbitPX)); %converts bit string to ASCII character
            if (pxCharacter == 'z') %10 Zs in a row is the deliminator
                delimitorCounter = delimitorCounter + 1; %increment it
            else
                delimitorCounter = 0; %if they're not in a row they'll never reach 10, each time this will be reset
            end
            messagestring = strcat(messagestring, pxCharacter); %add it to the messageString
            %reset bitCounter for the next character
            bitCounter = 0;
            eightbitPX = ''; %0x0 character
        end
        
        if (delimitorCounter == 10)
            break;
        end
        binaryPX = dec2bin( G(rowChannel, columnChannel),8 );
        eightbitPX = strcat(eightbitPX, binaryPX(7:8));
        bitCounter = bitCounter + 1;
        if (bitCounter == 4)
            pxCharacter = char(bin2dec(eightbitPX)); %converts bit string to ASCII character
            if (pxCharacter == 'z') %5 Zs in a row is the deliminator
                delimitorCounter = delimitorCounter + 1; %increment it
            else
                delimitorCounter = 0; %if they're not in a row they'll never reach 5, each time this will be reset
            end
            messagestring = strcat(messagestring, pxCharacter); %add it to the messageString
            %reset bitCounter for the next character
            bitCounter = 0;
            eightbitPX = ''; %0x0 character
        end
        
        if (delimitorCounter == 10)
            break;
        end
        binaryPX = dec2bin( B(rowChannel, columnChannel),8 );
        eightbitPX = strcat(eightbitPX, binaryPX(7:8));
        bitCounter = bitCounter + 1;
        if (bitCounter == 4)
            pxCharacter = char(bin2dec(eightbitPX));
            if (pxCharacter == 'z') %5 Zs in a row is the deliminator
                delimitorCounter = delimitorCounter + 1; %increment it
            else
                delimitorCounter = 0; %if they're not in a row they'll never reach 5, each time this will be reset
            end
            messagestring = strcat(messagestring, pxCharacter);
            bitCounter = 0;
            eightbitPX = '';
        end
    end %for()
    
    if (delimitorCounter == 10)
            break;
    end
end %for()

%disp(messagestring);