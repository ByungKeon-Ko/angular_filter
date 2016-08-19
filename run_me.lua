-- ===================================================================
-- To Do List ..
--	1. 

-- ===================================================================

-- Lua libraries
require 'image';

-- My libraries
package.path = package.path .. ";./lua_files/?.lua"
require 'load_image';
require 'local_angular_filter';

-- Parameters
dofile './lua_files/parameters.lua'

-- ===================================== --
-- 	Load Binary Images
-- ===================================== --
--  -- dInput form : Table, { .name, .img, .size }
--  -- each img array is torch tensor, dim : {1, 1, hei, wid }
dInput  = load_test_img_array(path_Img91_data )
collectgarbage()

-- ===================================== --
-- Apply Filter
-- ===================================== --
print("start to process image with brightness-dependent angular filter")
dOutput = {}
dOutput.name = {}
dOutput.size = {}
dOutput.img = {}
for i = 1, #(dInput.img) do
	print(i, dInput.name[i])
	dOutput.name[i] = dInput.name[i] .. '_filtered'
	dOutput.size[i] = dInput.size[i]
	dOutput.img[i] = br_dep_angular_filter(dInput.img[i], KernelSize)
end

collectgarbage()

-- ===================================== --
-- Save to jpeg file
-- ===================================== --
print("Start to Save Filtered Image!")
for i = 1, #(dOutput.img) do
	local filename = path_Img91_output .. dOutput.name[i] .. ".jpg"
	image.save(filename, torch.squeeze(dOutput.img[i]) )
end


