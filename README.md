# copilot-eldritch.nvim

A Lovecraftian-themed spinner for Copilot in Neovim. Shows fleeting, changing eldritch glyphs while Copilot is working in the background.

## Preview

![Demo GIF](./demo/demo.gif)

## Installation

Add this as a dependency of `copilot.lua`.

> **Note:** You must call `require("copilot-eldritch").setup()` **AFTER** `require("copilot").setup()`.

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "zbirenbaum/copilot.lua",
    dependencies = { "samiulsami/copilot-eldritch.nvim" },
    config = function()
        require("copilot").setup({...})
        require("copilot-eldritch").setup()
    end
}
```

## Configuration

Default options:

```lua
require("copilot-eldritch").setup({
    max_length = 73,
    min_length = 1,
    max_distance_from_cursor = 10,
    max_lines = 3,
    repeat_ms = 50,
    jitter_ms = 100, -- Random jitter added to repeat_ms for flickering effect
    rand_hl_group = "CopilotEldritchHLGroup",
    colors = {
        red = { min = 133, max = 255 },
        green = { min = 0, max = 0 },
        blue = { min = 68, max = 68 },
    },
    chars = { ... } -- See source for default glyphs
})
```

### Options Documentation

| Option | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `max_length` | `integer` | `73` | Maximum length of the generated spell string. |
| `min_length` | `integer` | `1` | Minimum length of the generated spell string. |
| `max_distance_from_cursor` | `integer` | `10` | Maximum random distance from the cursor position to start drawing glyphs. |
| `max_lines` | `integer` | `3` | Maximum number of lines (vertical) to spread the spell across. |
| `repeat_ms` | `integer` | `50` | Base speed of the animation tick in milliseconds. |
| `jitter_ms` | `integer` | `100` | Random jitter added to `repeat_ms` for the flickering disappearance effect (0 to N ms). |
| `rand_hl_group` | `string` | `"CopilotEldritchHLGroup"` | The highlight group used for the text. By default, the foreground color is randomized based on `colors`. |
| `colors` | `table` | `{...}` | RGB ranges for the random text color. Contains `red`, `green`, `blue`, each with `min` and `max` (0-255). |
| `chars` | `table` | `{...}` | A list of strings (glyphs) or a list of lists. If a list of lists is provided, a random set is chosen per activation. |

### Random Character Sets

You can provide a "list of lists" to `chars` to have the plugin pick a random "theme" or character set every time Copilot starts working.

```lua
require("copilot-eldritch").setup({
    chars = {
        { "a", "b", "c" },
        { "1", "2", "3" },
        { "!", "@", "#" },
    }
})
```

## Credits

- Inspired by [copilot-lualine](https://github.com/AndreM222/copilot-lualine)
