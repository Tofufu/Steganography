%   Tofufu
%   Please look at lsb.m/decodelsb.m for comments and explanations
%   Main.m: Contains User Prompt - calls encode / decode

%-------------------------User Prompt----------------------------------
task = input('Hello! Do you want to encode or decode?: ', 's');
while ~(strcmp(task, 'encode')  || strcmp(task, 'decode'))  
    task = input('Please enter encode|decode: ', 's');
end

filename = input('Can I get the filename?(ex: name.jpg): ', 's');

if (strcmp(task, 'encode'))
    eLSB(filename);
else
    dLSB(filename);
end