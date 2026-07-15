{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set smartindent
      set ignorecase
      set smartcase
      set clipboard=unnamedplus
      set termguicolors

      command! -bang Q q<bang>
      command! -bang W w<bang>
      command! -bang Wq wq<bang>
      command! -bang WQ wq<bang>
      command! -bang Qa qa<bang>
      command! -bang QA qa<bang>
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      catppuccin-nvim

      telescope-nvim
      plenary-nvim

      nvim-lspconfig
      
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip

      lualine-nvim

      nvim-autopairs
    ];

    initLua = ''
      vim.cmd.colorscheme("catppuccin") 

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

      require("lualine").setup()
      require("nvim-autopairs").setup()
      
      local cmp = require("cmp")
        cmp.setup({
        snippet = {
        expand = function(args)
        require("luasnip").lsp_expand(args.body)
       end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
       }),
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config('nil_ls', {})
      vim.lsp.enable('nil_ls')

      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<C-f>", require("telescope.builtin").live_grep)
    '';
  };

  home.packages = with pkgs; [
    nil 
  ];
}
