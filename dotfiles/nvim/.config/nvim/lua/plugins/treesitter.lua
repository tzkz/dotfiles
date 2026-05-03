return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  config = function()
    local treesitter = require 'nvim-treesitter'
    local parsers = { 'bash', 'c', 'diff', 'html', 'javascript', 'typescript', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

    treesitter.install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then return end

      vim.treesitter.start(buf, language)

      -- Enables treesitter based folds
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldmethod = 'expr'

      local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
      if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
    end

    local available_parsers = treesitter.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        local installed_parsers = treesitter.get_installed 'parsers'

        if vim.tbl_contains(installed_parsers, language) then
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          treesitter.install(language):await(function() treesitter_try_attach(buf, language) end)
        else
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
}
