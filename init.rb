module RedmineRedirectAfterCreate
  module IssuesControllerPatch
    def self.prepended(base)
      def redirect_after_create
        redirect_url = params[:redirect_url].to_s
        if redirect_url.present? && valid_back_url?(redirect_url)
          redirect_to redirect_url
        else
          super
        end
      end
    end
  end

  module RoutesHelperPatch
    def self.prepended(base)
      def _project_issues_path(project, *args)
        if params[:redirect_url]
          options = args.extract_options!
          options = options.reverse_merge redirect_url: params[:redirect_url]
          args << options
        end
        super project, *args
      end
    end
  end
end

class AfterPluginsLoadedHook < Redmine::Hook::Listener
  def after_plugins_loaded(_context = {})
    IssuesController.prepend RedmineRedirectAfterCreate::IssuesControllerPatch
    RoutesHelper.prepend RedmineRedirectAfterCreate::RoutesHelperPatch
  end
end

Redmine::Plugin.register :redmine_redirect_after_create do
  name "Redmine Redirect After Create Plugin"
  author "Intera GmbH"
  description "This plugin redirects the user to a custom URL after ticket creation based on a URL parameter."
  version "0.1.0"
  url "https://github.com/Intera/redmine_redirect_after_create"
  requires_redmine :version_or_higher => "6.0.0"
end
