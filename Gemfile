source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

# 我添加的gems
# net ssh
gem 'net-ssh'
# bootstrap
gem 'bootstrap-sass'
# 分页
gem 'will_paginate'
gem 'bootstrap-will_paginate'
# devise登陆注册模块
gem 'devise'
# 随机生成用户数据
gem 'faker', '1.4.2'
# postgresql 数据库
gem 'pg'
# 密码加密
gem 'bcrypt'
# 头像上传处理
gem 'paperclip', '~> 5.0.0.beta1'
# amazon s3 图片服务器
gem 'aws-sdk', '~> 2.3'
# jquery-turbolinks
gem 'jquery-turbolinks'

# ip地址推算城市
gem 'geoip'

# 分享
gem 'social-share-button'

gem 'rename'

# 搜索引擎
gem 'sunspot_rails'
gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development

# bootstrap 与 html5 data-confirm
gem 'data-confirm-modal', github: 'ifad/data-confirm-modal'

gem 'adminlte2-rails'

# ChartJS 图表
gem 'chartjs-ror'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :test do
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  gem 'guard'
  gem 'guard-minitest'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # gem 'better_errors'
end

group :production do
  gem 'rails_12factor'
  # gem 'unicorn'
  gem 'puma'
end
