return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "flake8",
        "prettier",
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
