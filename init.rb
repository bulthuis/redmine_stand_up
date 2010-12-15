require 'redmine'

Redmine::Plugin.register :redmine_stand_up do
  name 'Stand Up'
  author 'Bjørn Bulthuis'
  description 'Adds a page to make daily stand-ups more informative.'
  version '0.3'
  url 'http://github.com/sigbus/stand-up'
  author_url 'http://thebjornidentity.com'
end
