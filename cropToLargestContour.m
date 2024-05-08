function croppedMRI = cropToLargestContour(filename)
    MRI = imread(filename);
    % Perform edge detection using Canny edge detection
    edges = edge(imadjust(rgb2gray(MRI)), 'Canny');
    
    % Find contours of the edge-detected image
    contours = bwboundaries(edges);
    
    % Find the largest contour (assuming it corresponds to the brain boundary)]
    xmin = min(contours{1}(:,2));
    ymin = min(contours{1}(:,1));
    xmax = max(contours{1}(:,2));
    ymax = max(contours{1}(:,1));
    for k = 1:length(contours)
        boundary = contours{k};
        xmin = min(xmin, min(contours{k}(:,2)));
        ymin = min(ymin, min(contours{k}(:,1)));
        xmax = max(xmax, max(contours{k}(:,2)));
        ymax = max(ymax, max(contours{k}(:,1)));
    end
    
    % Extract bounding box of the brain boundary
    width = xmax - xmin;
    height = ymax - ymin;
    
    % Crop the MRI image using the bounding box
    croppedMRI = imcrop(MRI, [xmin ymin width height]);
end