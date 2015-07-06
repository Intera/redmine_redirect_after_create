module RedmineRedirectAfterCreate

  # Patches Redmine's IssuesController dynamically.  Modifies the redirect_after_create() method.
  module IssuesControllerPatch

    def self.included(base) # :nodoc:

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        def redirect_after_create_with_custom_url

          redirect_url = params[:redirect_url].to_s
          if redirect_url.present? && valid_back_url?(redirect_url)
            redirect_to redirect_url
          else
            # noinspection RubyResolve
            redirect_after_create_without_custom_url
          end

        end

        alias_method_chain :redirect_after_create, :custom_url
      end

    end

  end
end

IssuesController.send(:include, RedmineRedirectAfterCreate::IssuesControllerPatch)