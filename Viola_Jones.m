clear;
% In order to be able to select all sort of images based on their extension
[filename, path] = uigetfile('*.*', 'Select an image');
loc = strcat(path, filename);
pic = imread(loc);

% Face detection

% vision.CascadeObjectDetector creates a detector to identify objects using 
%the Viola-Jones algorithm
FDetect = vision.CascadeObjectDetector;
% We iterate through the image while getting bounding box around the
% detected face
bb = step(FDetect, pic);
imshow(pic);

if ~isempty(bb) % If the face is detected
    for i = 1 : size(bb)
        % We use a rectangle form to fit the face
        rectangle('Position', bb(i, :), 'LineWidth', 5, 'LineStyle', '-', 'EdgeColor', 'r');
    end
else % If the face could not be detected
    position = [0 0];   % Top Left corner
    label = 'No face has been detected';
    imgFail = insertText(pic, position, label, 'FontSize', 25, 'BoxOpacity', 1);
    imshow(imgFail)
end    

% Nose detection
% A Threshold is one of the attributes used by the CascadeObjectDetector
% function
% We use a Threshold in order to improve our detection
NoseDetect = vision.CascadeObjectDetector('Nose', 'MergeThreshold', 20);
bb = step(NoseDetect, pic);
for i = 1 : size(bb, 1)
    rectangle('Position', bb(i, :), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'b');
end

% Mouth detection
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold', 300);
bb = step(MouthDetect,pic);
for i = 1 : size(bb, 1)
 rectangle('Position',bb(i, :),'LineWidth', 2,'LineStyle','-','EdgeColor','y');
end

% Eyes detection
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
bb = step(EyeDetect, pic);
for i = 1 : size(bb, 1)
    rectangle('Position', bb(i, :), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'g');
end
