#
# MongoDB
#
require 'mongoid'

# サーバーに関する設定の読み込み
Mongoid.load! 'mongoid.yml', :test

# create()などで直接IDを指定できるようにするための設定
Mongoid.protect_sensitive_fields = false

