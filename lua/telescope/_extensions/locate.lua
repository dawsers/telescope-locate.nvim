local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugin requires nvim-telescope/telescope.nvim')
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

 -- opts.file needs to have spaces scaped, for example:
 -- :Telescope locate file=*/Vulkan\ *
 -- is similar to: locate "*/Vulkan *"
local function locate(opts)
  opts = opts or {}
  if not opts.file then
      error("'Telescope locate' needs a 'file' option")
  end
  pickers.new(opts, {
    prompt_title = "Locate",
    finder = finders.new_oneshot_job({ "locate", opts.file }, opts),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

return telescope.register_extension {
  exports = {
    locate = locate
  }
}

