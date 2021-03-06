%Tofufu c:
%LSB Stenography
% 1. Ask User (ENCODING):
%             filename
%             # of bits to change (1 | 2 | 3)
%             Message to encode
% 2. Perform Stenography and present the before and after image
% 
% 1. Ask User (DECODING):
%             filename
%             # of bits changed
% 2. Print out the message
%             

% Variable List
% task = encoding/decoding
% filename
% bitsToChange = # bits from LSB we're placing msg in each channel (RGB)
% encodingMessage = message we're going to encode into the image
% binaryMessage = binary version of the encoded message
% testing = filler variable used throughout to make code 'cleaner'
% originalImage = imread() image
% height/width = image's h/w
% rowChannel/columnChannel = current row/col of px inside each channel
% R/G/B = matrix of px - separated channels
% binaryR/G/B = binary conversion of the uint8 px we change the LSB of
% newImage = image w/ message inside

%-------------------------User Prompt----------------------------------
% task = input('Hello! Do you want to encode or decode?: ', 's');
% %nor: 00 = 1 ask the while loop, 01|10|11 = don't execute while loop
% while ~(strcmp(task, 'encode')  || strcmp(task, 'decode'))  
%     task = input('Please enter encode|decode: ', 's');
% end
% 
% filename = input('Can I get the filename?(ex: name.jpg): ', 's');
% 
% bitsToChange = input('How many bits to encode the msg from LSB? (1|2|3): ', 's');
% bitsToChange = str2num(bitsToChange); % User input comes in as a string
% while (bitsToChange > 3) || (bitsToChange < 0)
%     bitsToChange = input('Please enter (1|2|3): ', 's');
%     bitsToChange = str2num(bitsToChange);
% end

% Converting message to binary so that we can put it in the LSB
% I'm going to do this as ascii charc --> ascii # --> binary
% dec2bin('character') changes character to its ascii decimal number and then to binary
% returns matrix
%     row = # of characters
%     column = # of bits (8)
%     Each character = (#, :);
% to test str(bin2dec('10001000')) <-- gives back the ascii character
encodingMessage = input('What is your message?: ', 's');
binaryMessage = dec2bin(encodingMessage, 8); %min 8 bits
%We have to make the message into 1 long row character array (flatten the
%matrix) because each character = 1 row from dec2bin()
% (:) flattens row wise so have to transpose first
%   ex: testing = [1 2 3; 4 5 6]
%                   = 1 2 3
%                     4 5 6
%         testing(:) = 1;4;2;5;3;6;
binaryMessageTranspose = binaryMessage';
binaryMessage = (binaryMessageTranspose(:))';

% TODO: have to do math to limit the amount of characters depending on the
% size of the image

originalImage = imread('1.jpg');
% Inside the matrix are uint8 numbers - unsigned 8-bit 1byte integers so we
% can replace the LSB of each channel.

% TODO: test run on 2 last bits replaced first, then going to edit with
% user prompt/diff # of bits being placed

[height, width, testing] = size(originalImage); %getting the 

%separating the channels
R = originalImage(:, :, 1);
G = originalImage(:, :, 2);
B = originalImage(:, :, 3);

% NOTE: When you pass variables into MATLAB functions the values do not change
% from where it's called. Has to be set = to in caller. (for eLSB.m)
for rowChannel = 1:height
    for columnChannel = 1:width %horizontal replacement
        %Could probably put these in different functions :P but just so
        %everythings located here I'm just repeating it over and over
        binaryR = dec2bin( R(rowChannel, columnChannel) );
        binaryR(7:8) = binaryMessage(1:2); %replacing 2 bits
        R(rowChannel, columnChannel) = bin2dec(binaryR); %placing it back in
        binaryMessage = binaryMessage(3:end); %moving along the message
        if ( isempty(binaryMessage) ) %we're at the end
            break;
        end
        
        binaryG = dec2bin( G(rowChannel, columnChannel) );
        binaryG(7:8) = binaryMessage(1:2);
        G(rowChannel, columnChannel) = bin2dec(binaryG);
        binaryMessage = binaryMessage(3:end);
        if ( isempty(binaryMessage) ) %At the end
            break;
        end
        
        
        binaryB = dec2bin( B(rowChannel, columnChannel) );
        binaryB(7:8) = binaryMessage(1:2);
        B(rowChannel, columnChannel) = bin2dec(binaryB);
        binaryMessage = binaryMessage(3:end);
        if ( isempty(binaryMessage) ) %At the end
            break;
        end
    end
    
    if ( isempty(binaryMessage) ) %2nd break when at end
        break;
    end
end

% placing them back together
newImage = zeros(height, width, testing);
newImage(:,:,1) = R;
newImage(:,:,2) = G;
newImage(:,:,3) = B;
newImage = uint8(newImage); %converting back to 8 bits per px so we can display

%looks like the image is exactly in pixel form the same when i replace it,
%something is going on with writing over it

%imshow(newImage);

% I FOUND OUT THE REASON WHY. JPG PLS. I didn't think about the lossy
% compression which happens when saving stuff via jpeg. Wasn't the code's
% fault but the Quantization method that occurs when MATLAB saves the
% image. "Bug" fixed by just saving it as PNG/BMP - :D Each pixel comes out
% exactly the same as when I changed it in the code! 

imwrite(newImage, 'testing.png'); %saves the new encoding image into current folder of the code

