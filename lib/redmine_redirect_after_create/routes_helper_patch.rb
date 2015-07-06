module RedmineRedirectAfterCreate

  # Patches Redmine's RoutesHelper dynamically.  Appends redirect_url to _project_issues_path.
  module RoutesHelperPatch

    def self.included(base) # :nodoc:

      # Same as typing in the class
      base.class_eval do

        unloadable # Send unloadable so it will not be unloaded in development

        def _project_issues_path_with_redirect_url(project, *args)

          if params[:redirect_url]
            options = args.extract_options!
            options = options.reverse_merge(redirect_url: params[:redirect_url])
            args << options
          end

          # noinspection RubyResolve
          _project_issues_path_without_redirect_url(project, *args)

        end

        alias_method_chain :_project_issues_path, :redirect_url
      end

    end

  end
end

RoutesHelper.send(:include, RedmineRedirectAfterCreate::RoutesHelperPatch)