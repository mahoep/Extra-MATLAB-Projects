% Size of each picture
m = 200;
n = 175;

% Number of sample pictures
N = 20;

% Number of people
P = 2;

% Initialize data matrix (each row is an image) and counter
B = zeros(m*n,N*P);
count = 1;

% Load Sylvester Stallone
for j = 1:N
    
    % Read the image into a matrix
    ff = sprintf('faces/stallone%02d.jpg',j);
    v = imread(ff); 
    
    % Display the image
    figure(1)
    imshow(v)
    pause(0.1);
    
    % Remove the color (if necessary)
    if (size(v,3) > 1)
        v = rgb2gray(v);
    end
    
    % Convert to double format
    v=double(v); 
    
    % Reshape image data from a matrix to a vector
    v = reshape(v,m*n,1);
    
    % Add to our data matrix A (note I'm using columns instead of rows)
    B(:,count) = v;
    count = count + 1;
end

% Load Taylor Swift
for j = 1:N
    
    % Read the image into a matrix
    ff = sprintf('faces/taylor%02d.jpg',j);
    v = imread(ff); 
    
    % Display the image
    figure(1)
    imshow(v)
    pause(0.1);
    
    % Remove the color (if necessary)
    if (size(v,3) > 1)
        v = rgb2gray(v);
    end
    
    % Convert to double format
    v=double(v); 
    
    % Reshape image data from a matrix to a vector
    v = reshape(v,m*n,1);
    
    % Add to our data matrix A (note I'm using columns instead of rows)
    B(:,count) = v;
    count = count + 1;
end
count = count - 1;
u = reshape(double(rgb2gray(imread('faces/mystery.jpg'))),m*n,1);

save('imag_data.mat', 'B', 'u');