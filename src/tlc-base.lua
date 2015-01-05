local _c=function(b,c)for d,e in pairs(c)do b[d]=e end;return b end
local tlc = {}

function tlc:load(modules, baseDir)
  baseDir = baseDir or "lib.tlc."
--   modules = modules or {
--     "tlc-logic",
--     "tlc-math",
--     "tlc-misc",
--     "tlc-string",
--     "tlc-tables",
--     "tlc-types"
--   }
  for i, name in ipairs(modules) do
    local module = require (baseDir .. name)
    _c(self, module)
  end
  return self
end

return tlc
