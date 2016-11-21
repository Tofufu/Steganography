%encoding LSB. eLSB = primary function
function eLSB(filename)
%------------------------Reading Image/Channels------------------------
originalImage = imread(filename);
[height, width, testing] = size(originalImage);
R = originalImage(:, :, 1);
G = originalImage(:, :, 2);
B = originalImage(:, :, 3);

%------------------------Prompt----------------------------------------
newImageName = input('Name to save new image?: ', 's');
newImageName = strcat(newImageName, '.png');
bitsToChange = input('How many bits to encode the msg from LSB? (1|2): ', 's');
bitsToChange = str2num(bitsToChange); 
while (bitsToChange > 2) || (bitsToChange < 0)
    bitsToChange = input('Please enter (1|2): ', 's');
    bitsToChange = str2num(bitsToChange);
end

encodingMessage = input('What is your msg?: ', 's');
maxCharacters = round(((bitsToChange*(height*width*3))/8)-10); %not sure if correct ('_')
while (size(encodingMessage, 2) > maxCharacters)
    maxPrint = sprintf('Msg has to be less than %d characters. You currently have %d characters.',maxCharacters, size(encodingMessage,2));
    disp(maxPrint)
    encodingMessage = input('Please Enter ?: ', 's');
end
%------------------------Transforming Message------------------------ 
encodingMessage = strcat(encodingMessage, 'zzzzzzzzzz'); % Delimitor
%testingZ = encodingMessage(end-9:end);
binaryMessage = dec2bin(encodingMessage, 8);
binaryMessageTranspose = binaryMessage';
binaryMessage = (binaryMessageTranspose(:))';

%------------------------Replacing Bits------------------------
for rowChannel = 1:height
    for columnChannel = 1:width
        %----------------RED----------------
        [binaryRGB, binaryMessage] = replacingLSB(R(rowChannel, columnChannel), binaryMessage, bitsToChange);
        R(rowChannel, columnChannel) = bin2dec(binaryRGB); 
        if ( isempty(binaryMessage) ) 
            break;
        end
        %----------------GREEN----------------
        [binaryRGB, binaryMessage] = replacingLSB(G(rowChannel, columnChannel), binaryMessage, bitsToChange);
        G(rowChannel, columnChannel) = bin2dec(binaryRGB);
        if ( isempty(binaryMessage) ) 
            break;
        end
        %----------------BLUE----------------
        [binaryRGB, binaryMessage] = replacingLSB(B(rowChannel, columnChannel), binaryMessage, bitsToChange);
        B(rowChannel, columnChannel) = bin2dec(binaryRGB);
        if ( isempty(binaryMessage) ) 
            break;
        end
    end %for column()
    if ( isempty(binaryMessage) ) %2nd break when at end
        break;
    end
end %for row()

%------------------------New Encoded Image------------------------
newImage = zeros(height, width, testing);
newImage(:,:,1) = R;
newImage(:,:,2) = G;
newImage(:,:,3) = B;
newImage = uint8(newImage);
imwrite(newImage, newImageName);

end %main()

%------------------------Function Replaces Bits------------------------
function [binaryPX, new_binaryMessage] = replacingLSB(pxUINT8, binaryMessage, numBitsReplacing)
binaryPX = dec2bin(pxUINT8, 8);
if (numBitsReplacing == 1)
    binaryPX(8) = binaryMessage(1); %replacing 1 bit
    new_binaryMessage = binaryMessage(2:end);
else %replacing 2 bits
    binaryPX(7:8) = binaryMessage(1:2); 
    new_binaryMessage = binaryMessage(3:end);
end %if ()

end % replacingLSB()