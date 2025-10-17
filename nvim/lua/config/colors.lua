local function	set_hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

set_hl("@keyword.import", { fg = "#F92672" })
set_hl("@string.c", { fg = "#E6DB74" })

set_hl("@type.builtin.c", { fg = "#66D9EF" })

set_hl("@function.c", { fg = "#A6E22E" })
set_hl("@function.call.c", { fg = "#A6E22E" })

set_hl("@variable.c", { fg = "#FD971F" })

set_hl("@keyword.conditional.c", { fg = "#F92672" })
