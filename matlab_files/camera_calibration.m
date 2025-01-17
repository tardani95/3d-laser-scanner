% Auto-generated by cameraCalibrator app on 15-Apr-2018
%-------------------------------------------------------


% Define images to process
imageFileNames = {'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image21.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image22.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image23.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image24.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image25.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image26.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image27.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image28.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image29.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image30.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image31.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image32.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image33.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image35.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image36.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image37.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image43.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image62.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image63.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image72.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image73.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image74.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image75.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image76.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image77.png',...
    'C:\uni\mech_proj\3d_laser_scanner\calibration_images\Image78.png',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 1.450000e+01;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
