clear;close all;
clc;
%% settings
default_folder = '../dataset/';
setname = 'Img91';
output_dir = strcat(default_folder, 'binary_files/');
folder = strcat( default_folder, setname);
scale = 3;

%% initialization
count = 0;

%% generate data
filepaths = dir(fullfile(folder,'*.bmp'));
    
for i = 1 : length(filepaths)
	image = imread(fullfile(folder,filepaths(i).name));
	image = rgb2ycbcr(image);
	image = im2double(image(:, :, 1));
	
	im_label = modcrop(image, scale);
	[hei,wid] = size(im_label);
	im_input = imresize(imresize(im_label,1/scale,'bicubic'),[hei,wid],'bicubic');
	
	% order = randperm(count);
	tmpstring = strsplit(filepaths(i).name, '.');
	imgname = tmpstring{1};
	
	filename = strcat(output_dir, setname, '/input_', imgname, '_', int2str(hei), '_', int2str(wid), '.bin');
	fileID = fopen(filename, 'w');
	fwrite(fileID, im_input*255.0, 'uint8');
	fclose(fileID);
	
	filename = strcat(output_dir, setname, '/label_', imgname, '_', int2str(hei), '_', int2str(wid), '.bin');
	fileID = fopen(filename, 'w');
	fwrite(fileID, im_label*255.0, 'uint8');
	fclose(fileID);
end
    

