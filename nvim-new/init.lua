require('config.options')
require('config.autocmds')

require('config.lazy')
_G.Util = require('util')

-- Since keymaps use globals from snacks it needs to be loaded last
require('config.keymaps')
