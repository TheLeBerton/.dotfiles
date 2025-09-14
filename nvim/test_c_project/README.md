# C Project LSP Test

This is a test C project to verify your Neovim LSP setup with clangd.

## Project Structure
```
test_c_project/
├── src/
│   ├── main.c      # Main program entry point
│   └── utils.c     # Utility functions
├── include/
│   └── utils.h     # Header file with function declarations
├── Makefile        # Build configuration
└── README.md       # This file
```

## Building and Running

```bash
# Build the project
make

# Build and run
make run

# Clean build files
make clean

# Build with debug flags
make debug
```

## Testing LSP Features

Open any `.c` or `.h` file in Neovim and test these LSP features:

### Navigation
- `gd` - Go to definition (try on `calculate_sum` in main.c)
- `gr` - Find references
- `K` - Hover documentation

### Code Actions
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format code

### Diagnostics
- `[d` / `]d` - Navigate diagnostics
- `<leader>e` - Show diagnostic details

## What to Test

1. **Go to definition**: Put cursor on `calculate_sum` in main.c, press `gd`
2. **Find references**: Put cursor on any function name, press `gr`
3. **Hover docs**: Put cursor on any function, press `K`
4. **Rename**: Put cursor on a variable, press `<leader>rn`
5. **Code completion**: In insert mode, start typing and see suggestions

Enjoy testing your LSP setup!