# nvim-uuid

`nvim-uuid` is a plugin that allows to generate uuid's on the fly in neovim.

## Dependencies

- `nvim-uuid` depends on `uuid-runtime` package installed globally. Checkout the installation guide [here](https://www.digitalocean.com/community/tutorials/workflow-command-line-basics-generating-uuids).

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
require("lazy").setup({
  {
    "ofadiman/nvim-uuid",
  },
}
```

## Configuration

If you want to override the default settings of the plugin, use the instructions below:

```lua
require("nvim-uuid").setup({
  should_move_cursor_after_generating_uuid = true,
  case = "lower",
})
```

| Option                                   | Description                                                                                    | Possible values       | Default value |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------- | --------------------- | ------------- |
| should_move_cursor_after_generating_uuid | Determines whether the cursor will be moved to the end of the generated uuid or stay in place. | `true` or `false`     | `true`        |
| case                                     | Determines whether the uuid will be in uppercase or lowercase.                                 | `"upper"`or `"lower"` | `"lower"`     |
