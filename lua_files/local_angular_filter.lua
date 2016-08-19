-- ===================================================================
-- To Do List ..
--	1. 

-- ===================================================================

-- Lua libraries
require 'image';

-- Torch basic libraries
require 'nn';


local function zero_padding( i_img, KernelSize )
	local pix = 0
	local pad = (KernelSize-1)/2
	ndim = i_img:dim()

	local s = nn.Sequential()
		:add(nn.Padding(ndim-1,  pad, ndim, pix))
		:add(nn.Padding(ndim-1, -pad, ndim, pix))
		:add(nn.Padding(ndim  ,  pad, ndim, pix))
		:add(nn.Padding(ndim  , -pad, ndim, pix))

	return s:forward(i_img)
end

local function angular_filter ( rcpt_field, angle)
	local sum = 0
	if angle == 0 then
		for i = 1, KernelSize do
			sum = sum + rcpt_field[1][1][(KernelSize-1)/2+1][i]
		end
		return sum / KernelSize
	elseif angle == 1 then
		for i = 1, KernelSize do
			sum = sum + rcpt_field[1][1][i][i]
		end
		return sum / KernelSize
	elseif angle == 2 then
		for i = 1, KernelSize do
			sum = sum + rcpt_field[1][1][i][(KernelSize-1)/2+1]
		end
		return sum / KernelSize
	elseif angle == 3 then
		for i = 1, KernelSize do
			sum = sum + rcpt_field[1][1][i][KernelSize+1-i]
		end
		return sum / KernelSize
	else
		print ("Wrong Angle was inserted! @ local_angular_filter.lua, func: angular_filter")
		return -1
	end
end

-- Brightness-Dependent Angular Filter
--  -- i_img is torch tensor, dim : {1, 1, hei, wid }
function br_dep_angular_filter( i_img, KernelSize )
	local hei = (#i_img)[3]
	local wid = (#i_img)[4]

	local o_padding = zero_padding( i_img, KernelSize )
	
	local pad = (KernelSize-1)/2
	local o_filter = torch.Tensor(1,1,hei+pad*2, wid+pad*2)

	for idx_y=1+pad, hei+pad do
		for idx_x=1+pad, wid+pad do
			local pix =  o_padding[1][1][idx_y][idx_x] * 255.0
			local receptive_field = o_padding[{ {},{},{idx_y-pad,idx_y+pad},{idx_x-pad,idx_x+pad} }]
			if pix < 64 then
				o_filter[1][1][idx_y][idx_x] = angular_filter(receptive_field, 0)
			elseif pix < 128 then
				o_filter[1][1][idx_y][idx_x] = angular_filter(receptive_field, 1)
			elseif pix < 192 then
				o_filter[1][1][idx_y][idx_x] = angular_filter(receptive_field, 2)
			else
				o_filter[1][1][idx_y][idx_x] = angular_filter(receptive_field, 3)
			end
		end
	end

	return o_filter[{ {},{},{1+pad, hei+pad},{1+pad, wid+pad} }]
end

