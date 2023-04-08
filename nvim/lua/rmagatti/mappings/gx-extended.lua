require("gx-extended").setup {
  extensions = {
    {
      autocmd_pattern = { "*.tf" },
      match_to_url = function(line_string)
        local resource_name = string.match(line_string, 'resource "aws_([^"]*)"')
        local url = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/" .. resource_name

        return url
      end,
    },
  },
}
