
function subrange(t, first, last)
  local sub = {}
  for i=first,last do
    sub[#sub + 1] = t[i]
  end
  return sub
end

function shave(img_input, height, width )
	local img_output = img_input[{ {}, {}, {1+SizeGap/2, height-SizeGap/2}, {1+SizeGap/2, width - SizeGap/2} }]
	return img_output
end

-- Open code from Internet
-- Lua implementation of PHP scandir function
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

function select_in_img_table ( img_table, idx )
	local selected_img = {}
	selected_img.img  = img_table.img[idx]
	selected_img.name = img_table.name[idx]
	selected_img.size = img_table.size[idx]

	return selected_img
end



