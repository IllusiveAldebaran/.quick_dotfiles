function RandomSeq(len)
	local bases = { "A", "C", "G", "T" }
	local seq = {}
	for i = 1, len do
		seq[i] = bases[math.random(1, 4)]
	end
	return table.concat(seq)
end

vim.keymap.set('n', '<leader>f', function()
	local len = tonumber(vim.fn.input("Sequence length: "))
	if len and len > 0 then
		vim.api.nvim_put({ RandomSeq(len) }, 'c', true, true)
	end
end, { desc = "Insert random ACGT sequence" })
