function dLSB(filename)

bitsChanged = input('Bits Changed? (1|2): ', 's');
bitsChanged = str2num(bitsChanged); 
%------------------------Reading Image/Setting Variables------------------------
image = imread(filename);
[height, width, testing] = size(image);
R = image(:, :, 1);
G = image(:, :, 2);
B = image(:, :, 3);

messagestring = '';
delimitorCounter = 0; 
bitCounter = 0; 
eightbitPX = ''; 
%------------------------Going through each PX------------------------
for rowChannel = 1:height
    for columnChannel = 1:width
        %---------------RED---------------
        if (delimitorCounter == 10)
            break;
        end
        [eightbitPX, messagestring, bitCounter, delimitorCounter] = convertingBits( R(rowChannel, columnChannel), eightbitPX, bitCounter, delimitorCounter, messagestring, bitsChanged);
        %---------------GREEN---------------
        if (delimitorCounter == 10)
            break;
        end
        [eightbitPX, messagestring, bitCounter, delimitorCounter] = convertingBits( G(rowChannel, columnChannel), eightbitPX, bitCounter, delimitorCounter, messagestring, bitsChanged);
        %---------------BLUE---------------
        if (delimitorCounter == 10)
            break;
        end
        [eightbitPX, messagestring, bitCounter, delimitorCounter] = convertingBits( B(rowChannel, columnChannel), eightbitPX, bitCounter, delimitorCounter, messagestring, bitsChanged);
    
    end % for column()
    if (delimitorCounter == 10)
            break;
    end
end %for row()
%---------------DISPLAYING MESSAGE---------------
disp(messagestring);

end %dLSB()

%------------------------Function Translates UINT8 to Character/Saves Msg------------------------
function [eightbitPX, messagestring, bitCounter, delimitorCounter] = convertingBits(pxUINT8, eightbitPX, bitCounter, delimitorCounter, messagestring, bitsChanged)
binaryPX = dec2bin(pxUINT8, 8);

if (bitsChanged == 2)
    eightbitPX = strcat(eightbitPX, binaryPX(7:8));
else
    eightbitPX = strcat(eightbitPX, binaryPX(8));
end

bitCounter = bitCounter + 1;
if ((bitCounter == 4) && (bitsChanged == 2)) || ((bitCounter == 8) && (bitsChanged == 1))
    pxCharacter = char(bin2dec(eightbitPX)); 
    if (pxCharacter == 'z') 
        delimitorCounter = delimitorCounter + 1;
    else
        delimitorCounter = 0;
    end
    % REACHED 8 BITS
    messagestring = strcat(messagestring, pxCharacter); 
    bitCounter = 0;
    eightbitPX = '';
end

end %covertingBits()