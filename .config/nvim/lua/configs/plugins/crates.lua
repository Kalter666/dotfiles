return function(_, opts)
  local crates = require "crates"
  crates.setup(opts)
  crates.show()
end
