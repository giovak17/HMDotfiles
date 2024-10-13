-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
--
return {
  "nvim-lualine/lualine.nvim",
  init = function()
    -- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
	none = "NONE",
	fg = "#E1E1E1",
	grey = "#151515",
	alt_bg = "#171717",
	black = "#171717",
	accent = "#202020",
	white = "#E1E1E1",
	gray = "#373737",
	medium_gray = "#727272",
	light_gray = "#AFAFAF",
	blue = "#BAD7FF",
	gray_blue = "#7E97AB",
	medium_gray_blue = "#A2B5C1",
	cyan = "#88afa2",
	red = "#b46958",
	green = "#90A959",
	yellow = "#F4BF75",
	orange = "#FFA557",
	violet = "#AA749F",
	magenta = "#AA759F",
	cursor_fg = "#151515",
	cursor_bg = "#D0D0D0",
	sign_add = "#586935",
	sign_change = "#51657B",
	sign_delete = "#984936",
	error = "#984936",
	warning = "#ab8550",
	info = "#ab8550",
	hint = "#576f82",
	todo = "#578266",
	accent_blue = "#191a20",
	accent_green = "#1c2019",
	accent_red = "#201919",
}

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.cyan },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
      },

      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.green } },
      replace = { a = { fg = colors.black, bg = colors.red } },

      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
    }

    require("lualine").setup({
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch" },
        lualine_c = {
          "%=", --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
