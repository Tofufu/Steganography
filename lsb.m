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

% TODO: have to do math to limit the amount of characters depending on the
% size of the image

originalImage = imread('1.jpg');
% Inside the matrix are uint8 numbers - unsigned 8-bit 1byte integers so we
% can replace the LSB of each channel.

% TODO: test run on 2 last bits replaced first, then going to edit with
% user prompt/diff # of bits being placed

