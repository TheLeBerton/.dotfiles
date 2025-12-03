-- Minimal C & Makefile Theme for Treesitter
local function set_hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local colors = {
    bg = '#1C1C1C',
    fg = '#ebdbb2',
    -- Functions
    function_global = '#83a598',
    function_call = '#8ec07c',
    -- Types
    type_builtin = '#fabd2f',
    type_class = '#d79921',
    type_qualifier = '#fabd2f',
    -- Variables
    variable_local = '#b8bb26',
    variable_parameter = '#fe8019',
    -- Constants/Macros
    constant = '#fb4934',
    macro_global = '#cc241d',
    -- Literals
    string = '#b8bb26',
    character = '#b8bb26',
    number = '#d3869b',
    -- Keywords
    keyword = '#d3869b',
    keyword_modifier = '#fb4934',
    -- Operators & punctuation
    operator = '#ebdbb2',
    bracket = '#fe8019',
    delimiter = '#928374',
    -- Comments
    comment = '#928374',
    preproc = '#fe8019',
}

-- === C highlights ===
set_hl("@keyword.c", { fg = colors.keyword, bold = true })
set_hl("@keyword.modifier.c", { fg = colors.keyword_modifier, italic = true })
set_hl("@function.c", { fg = colors.function_global, bold = true })
set_hl("@function.call.c", { fg = colors.function_call })
set_hl("@type.c", { fg = colors.type_builtin, bold = true })
set_hl("@type.builtin.c", { fg = colors.type_builtin, bold = true })
set_hl("@lsp.type.class.c", { fg = colors.type_class, bold = true })
set_hl("@lsp.type.parameter.c", { fg = colors.variable_parameter, bold = true })
set_hl("@string.c", { fg = colors.string, italic = true })
set_hl("@character.c", { fg = colors.character })
set_hl("@number.c", { fg = colors.number })
set_hl("@constant.c", { fg = colors.constant, bold = true })
set_hl("@operator.c", { fg = colors.operator })
set_hl("@punctuation.bracket.c", { fg = colors.bracket })
set_hl("@punctuation.delimiter.c", { fg = colors.delimiter })
set_hl("@comment.c", { fg = colors.comment, italic = true })
set_hl("@preproc.c", { fg = colors.preproc })
set_hl("@lsp.typemod.macro.globalScope.c", { fg = colors.macro_global, bold = true })

-- === Makefile highlights ===
set_hl("@keyword.make", { fg = colors.keyword, bold = true })
set_hl("@function.make", { fg = colors.function_global })
set_hl("@variable.make", { fg = colors.variable_local })
set_hl("@string.make", { fg = colors.string, italic = true })
set_hl("@comment.make", { fg = colors.comment, italic = true })
set_hl("@constant.make", { fg = colors.constant, bold = true })
set_hl("@operator.make", { fg = colors.operator })
