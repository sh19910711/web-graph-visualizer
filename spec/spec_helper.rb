#
# Load Helpers
#
require 'helpers/database_helper'
require 'helpers/mongoid_helper'
require 'helpers/factory_girl_helper'
require 'helpers/debug_helper'
require 'helpers/rack_helper'

#
# Tested Modules
#
require_relative '../lib/application/webapi'
require_relative '../lib/application/module01'
require_relative '../lib/application/models/input_text_model'
require_relative '../lib/application/models/parser_model'
require_relative '../lib/mongoid_dummy/models/dummy_model'

I18n.enforce_available_locales = true
