return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    keys = {
      {
        "<leader>mp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    cmd = { "MarkdownPreviewToggle" },
    build = ":call mkdp#util#install()",

    ft = { "markdown" },
  },
}
