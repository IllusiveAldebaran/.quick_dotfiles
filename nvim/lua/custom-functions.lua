function ToggleStatusLine()
 -- Check if the status line is currently visible
 local statusline = vim.o.laststatus
 if statusline == 2 then
    -- If the status line is visible, make it disappear
    vim.o.laststatus = 0
 else
    -- If the status line is not visible, make it appear
    vim.o.laststatus = 2
 end
end
