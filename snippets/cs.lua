-- local fmt = require("luasnip.extras.fmt").fmt
local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

--- See https://learncodethehardway.org/
--@diagnostic disable: undefined-global

local snippets = {}

table.insert(snippets, s({ trig = 'xc' }, { t { '/// <summary>', '/// ' }, i(1, 'comment'), t { '', '/// </summary>' } }))

return snippets, {
  -- s('autotrig', t 'autotriggered, if enabled'),
}
