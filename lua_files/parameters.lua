
path_Img91_data   = "./dataset/binary_files/Img91/input/"
path_Img91_output = "./dataset/angular_filter/input/"

KernelSize = 9

-- ** Input / Label Image Size Difference
-- SizeGap = 12
SizeGap = 0

imgsizeTrainInput = {}
imgsizeTrainInput.width  = 33
imgsizeTrainInput.height = 33
imgsizeTrainLabel = {}
imgsizeTrainLabel.width  = imgsizeTrainInput.width  - SizeGap
imgsizeTrainLabel.height = imgsizeTrainInput.height - SizeGap

