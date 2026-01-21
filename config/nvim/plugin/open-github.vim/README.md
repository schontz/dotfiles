# open-github.vim

A Vim plugin that opens GitHub pull requests, issues, and commits directly from references under your cursor.

## Features

- Open PRs/issues with a single keystroke
- Open commits from commit hashes
- Supports `#123` and `GH-123` notation for PRs/issues
- Supports commit hashes (8-40 hex characters)
- Automatically detects GitHub repository from `.git/config`
- Works with both SSH and HTTPS remotes
- Platform-agnostic (macOS, Linux, Windows)
- Compatible with Vim 8+ and Neovim

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'yourusername/open-github.vim'
```

### Using [Vundle](https://github.com/VundleVim/Vundle.vim)

```vim
Plugin 'yourusername/open-github.vim'
```

### Using [Pathogen](https://github.com/tpope/vim-pathogen)

```bash
cd ~/.vim/bundle
git clone https://github.com/yourusername/open-github.vim.git
```

### Using native package support (Vim 8+)

```bash
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/yourusername/open-github.vim.git
```

## Setup

Add a key mapping to your `.vimrc` or `init.vim`:

```vim
nmap <leader>gh <Plug>(open-github)  " Open PR/issue/commit
```

Or for Neovim with `init.lua`:

```lua
vim.keymap.set('n', '<leader>gh', '<Plug>(open-github)', { silent = true })
```

## Usage

1. Place your cursor on a PR/issue reference (e.g., `#123` or `GH-456`) or commit hash (e.g., `abc12345`)
2. Press your mapped key (e.g., `<leader>gh`) or run `:OpenGithub`
3. The PR/issue/commit will open in your default browser

The plugin intelligently detects whether you're referencing a PR/issue or a commit and opens the appropriate GitHub page.

### Supported Patterns

**PRs/Issues:**
- `#123`, `#12345` - Standard GitHub issue/PR notation
- `GH-123`, `gh-456` - GitHub notation (case-insensitive)

**Commits:**
- 8-40 character hexadecimal strings with word boundaries
- Examples: `abc12345`, `a1b2c3d4e5f67890`, full 40-character SHA

### Examples

**Opening a PR:**
```
See #1234 for more details
     ^
     cursor here, press <leader>gh
```
Opens: `https://github.com/org/repo/pull/1234`

**Opening a commit:**
```
Fixed in commit abc12345
                ^
                cursor here, press <leader>gh
```
Opens: `https://github.com/org/repo/commit/abc12345`

## Configuration

### Key Mappings

The plugin provides a `<Plug>` mapping that you can bind to any key combination.

Suggested mapping:

```vim
" Vim/Neovim (vimscript)
nmap <leader>gh <Plug>(open-github)  " Open GitHub PR/issue/commit
```

```lua
-- Neovim (Lua)
vim.keymap.set('n', '<leader>gh', '<Plug>(open-github)', { silent = true })
```

## How It Works

1. Extracts the text under cursor
2. Tries to match PR/issue patterns first (`#123`, `GH-123`)
3. If no PR/issue found, tries to match commit hash patterns (8-40 hex characters)
4. Finds the `.git/config` file by walking up the directory tree
5. Parses the GitHub remote URL (checks `origin` first, then `upstream`)
6. Constructs the appropriate GitHub URL:
   - PRs/issues: `https://github.com/org/repo/pull/NUMBER`
   - Commits: `https://github.com/org/repo/commit/HASH`
7. Opens the URL using your system's default browser

### Supported Remote Formats

- HTTPS: `https://github.com/org/repo.git`
- SSH: `git@github.com:org/repo.git`

## Commands

| Command | Description |
|---------|-------------|
| `:OpenGithub` | Open the GitHub PR/issue/commit under cursor |

## Mappings

The plugin does not set any default mappings. You must add mappings yourself (see Setup section above).

| Mapping | Mode | Description |
|---------|------|-------------|
| `<Plug>(open-github)` | Normal | Plug mapping for opening PRs/issues/commits |

## Troubleshooting

### Nothing happens when I press my mapped key

- Make sure you've added a key mapping to your `.vimrc` or `init.lua` (see Setup section)
- Ensure you're in a Git repository with a GitHub remote
- Check that your cursor is on a valid PR reference (`#123` or `GH-123`) or commit hash
- The plugin will show "No PR/issue or commit found" or "Not a Github repo" messages if something is wrong

### Wrong repository opens

The plugin uses the `origin` remote by default. If your `origin` doesn't point to the correct GitHub repository, update it:

```bash
git remote set-url origin git@github.com:org/repo.git
```

### Doesn't work with GitLab/Bitbucket

This plugin only supports GitHub repositories. It will silently fail for other Git hosting providers.

### URL doesn't open

Ensure your system has a default browser configured. The plugin uses:
- macOS: `open` command
- Linux: `xdg-open` command
- Windows: `start` command

### Commit hash isn't recognized

Commit hashes must be 8-40 hexadecimal characters with word boundaries. Make sure:
- The hash is at least 8 characters long (e.g., `abc12345`)
- It only contains hex characters (0-9, a-f, A-F)
- It's standalone, not embedded in a larger word (e.g., `test123abc` won't match)

## FAQ

### Can I use this for issues as well as PRs?

Yes! While the plugin constructs `/pull/` URLs, GitHub automatically redirects to `/issues/` if the number corresponds to an issue rather than a pull request.

### Does it work with private repositories?

Yes, as long as you're authenticated in your browser.

### Can I use custom PR number formats?

Currently, the plugin supports `#123` and `GH-123` patterns. If you need additional patterns, feel free to open an issue or submit a PR.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Credits

Created by David Schontzler

## Related Projects

- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git wrapper for Vim
- [vim-rhubarb](https://github.com/tpope/vim-rhubarb) - GitHub extension for fugitive.vim
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for Neovim
