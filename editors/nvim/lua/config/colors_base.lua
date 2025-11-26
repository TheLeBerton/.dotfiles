-- Minimal C Programming Theme for LSP C
local function set_hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Color Palette (3024 Night LSP C)
local colors = {
	bg = '#090300',
	fg = '#a5a2a2',

	-- Functions
	function_global = '#5f5fdf',
	function_call = '#5f5fdf',
	function_method = '#5f5fdf',

	-- Types
	type_builtin = '#01a0e4',
	type_class = '#01a0e4',
	type_qualifier = '#01a0e4',
	type_unused = '#6a6868',

	-- Variables
	variable_local = '#f4bf75',
	variable_parameter = '#ffbf5c',
	variable_unused = '#6a6868',
	property_class_scope = '#f4bf75',

	-- Constants / Macros
	constant = '#e8bbd0',
	macro_global = '#db2d20',

	-- Literals
	string = '#01a252',
	character = '#01a252',
	number = '#b5e4f4',

	-- Keywords
	keyword = '#cd3f45',
	keyword_modifier = '#cd3f45',
	keyword_repeat = '#cd3f45',
	keyword_return = '#cd3f45',

	-- Operators & punctuation
	operator = '#f7f7f7',
	bracket = '#a5a2a2',
	delimiter = '#a5a2a2',

	-- Comments / Preprocessor
	comment = '#807d7c',
	preproc = '#db2d20',
}

-- Example of usage with set_hl
set_hl("@keyword.import.c", { fg = colors.keyword })
set_hl("@keyword.conditional.c", { fg = colors.keyword, bold = true })
set_hl("@keyword.modifier.c", { fg = colors.keyword_modifier, italic = true })
set_hl("@keyword.repeat.c", { fg = colors.keyword_repeat, bold = true })
set_hl("@keyword.return.c", { fg = colors.keyword_return, bold = true })
set_hl("@keyword.c", { fg = colors.keyword, bold = true })

set_hl("@function.c", { fg = colors.function_global, bold = true })
set_hl("@function.call.c", { fg = colors.function_call })
set_hl("@lsp.typemod.function.globalScope.c", { fg = colors.function_global })

set_hl("@type.c", { fg = colors.type_builtin, bold = true })
set_hl("@type.builtin.c", { fg = colors.type_builtin, bold = true })
set_hl("@lsp.type.class.c", { fg = colors.type_class, bold = true })
set_hl("@type.qualifier.c", { fg = colors.type_qualifier })

set_hl("@lsp.typemod.variable.functionScope.c", { fg = colors.variable_local })
set_hl("@lsp.type.parameter.c", { fg = colors.variable_parameter, bold = true })
set_hl("DiagnosticUnnecessary", { fg = colors.variable_unused, italic = true })

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
set_hl("@lsp.typemod.property.classScope.c", { fg = colors.property_class_scope })
