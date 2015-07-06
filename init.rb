require 'redmine'
require 'redmine_redirect_after_create/issues_controller_patch'
require 'redmine_redirect_after_create/routes_helper_patch'

Redmine::Plugin.register :redmine_redirect_after_create do
  name 'Redmine redirect after create plugin'
  author 'Intera GmbH'
  description 'This plugin redirects the user to a custom URL after ticket creation based on a URL parameter.'
  version '0.0.1'
  url 'https://github.com/Intera/redmine_redirect_after_create'
end
