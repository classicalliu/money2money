# Money2Money
**p2p借贷系统**

[![Build Status](https://travis-ci.com/classicalliu/p2p_oracle.svg?token=hxoLUSj2NipoqpUjb6eG&branch=master)](https://travis-ci.com/classicalliu/p2p_oracle)

[Heroku](https://damp-reef-94440.herokuapp.com/)(搜索功能不可用)

## 安装

### 版本
* ruby 2.3.0
* rails 4.2.6

### 依赖
* ImageMagic
* Postgres9.4及以上
* JDK

### 安装
* bundle install
* bundle exec rake db:migrate
* bundle exec rake db:seed
* bundle exec rake sunspot:solr:start
* rails server
* bundle exec rake sunspot:solr:reindex


### 关闭solr
* bundle exec rake sunspot:solr:stop