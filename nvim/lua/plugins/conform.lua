return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      hcl = { "terragrunt_hclfmt", "hcl", stop_after_first = true },
      python = { "ruff_format", "ruff_organize_imports" },
      terraform = { "tofu_fmt", "terraform_fmt", stop_after_first = true },
    },
  },
}
